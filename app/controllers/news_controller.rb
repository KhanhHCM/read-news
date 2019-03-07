class NewsController < ApplicationController
  def index
    doc = Nokogiri::HTML(open('https://news.ycombinator.com/best')).css('a.storylink')
    @list_news = []
    doc.each do |post|
      news = {}
      link = post['href'].include?('http') ? post['href'] : "https://news.ycombinator.com/#{post['href']}"
      source = Nokogiri::HTML(open(link))
      description = source.xpath('//meta[@name="description"]')
      image_url   = source.xpath('//meta[@name="image"]')
      news["description"] = description.first ? description.first['content'] : post.text
      news["image_url"]   = image_url.first ? image_url.first['content'] : "default.png"
      news["url"] = link
      news["title"] = post.text
      @list_news << news
    end
  end

  def show
  end
end
