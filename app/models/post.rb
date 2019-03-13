class Post < ApplicationRecord
  belongs_to :author
  validates :title, uniqueness: true

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

  def news_content
    Nokogiri::HTML(open(self.url).read).css('article.content_detail').to_html
  end

  def timestamp
    created_at.strftime('%d %B %Y %H:%M')
  end

end
