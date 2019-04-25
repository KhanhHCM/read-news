class Post < ApplicationRecord
  belongs_to :author
  validates :url, :slug, uniqueness: true

  scope :vnexpress, ->{where source: 1}
  scope :random_order, -> {order('DBMS_RANDOM.VALUE')}

  acts_as_url :title, url_attribute: :slug, sync: true
  extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]

  def to_param
    "#{slug}"
  end

  def self.get_news
    require 'open-uri'
    url_source = "https://vnexpress.net"
    doc = Nokogiri::HTML(open(url_source).read).css('[id="list_sub_featured"]//li//a:nth-child(1)')
    list_news = []
    doc.each do |post|
      news = {}
      link = post['href'].include?('http') ? post['href'] : "#{params}/#{post['href']}"
      source = Nokogiri::HTML(open(link))
      description = source.xpath('//meta[@name="description"]')
      image_url   = source.xpath('//meta[@property="og:image"]')
      author1     = source.css('p.author_mail strong').empty? ?  nil : source.css('p.author_mail strong').text
      author2     = source.css('article.content_detail > p[style] > strong').empty? ? nil : source.css('article.content_detail > p[style] > strong').text unless author1
      author      = author1 || author2 || "Author"
      news["description"] = description.first ? description.first['content'] : post.text
      news["link_image"]   = image_url.first ? image_url.first['content'] : "default.png"
      news["url"] = link
      news["title"] = post.text
      news["author"] = author
      list_news << news
    end

    list_news.each do |news|
      next if news['url'].include?("video.") || news['url'].include?("/infographics/")
      Author.find_or_create_by!(name: news["author"]).posts.create(title: news['title'], description: news['description'], link_image: news['link_image'], url: news['url'])
    end

  end

  def self.update_news
    require 'open-uri'
    Post.all.each do |post|
      html = Nokogiri::HTML(open(post.url)).css('article.content_detail')
      post.update(html: html)
    end
  end

  def news_content
    self.html.to_html
  end

end
