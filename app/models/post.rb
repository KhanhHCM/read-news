class Post < ApplicationRecord
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
      news["description"] = description.first ? description.first['content'] : post.text
      news["link_image"]   = image_url.first ? image_url.first['content'] : "default.png"
      news["url"] = link
      news["title"] = post.text
      list_news << news
    end

    list_news.each do |news|
      self.create(title: news['title'], description: news['description'], link_image: news['link_image'], url: news['url'])
    end

  end

  def news_content
    source = open(self.url).read
    Readability::Document.new(source).content
  end

end
