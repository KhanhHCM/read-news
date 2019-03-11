class NewsController < ApplicationController
  def test
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

  def index
    @news = Post.select(:id, :title, :link_image, :description).order(created_at: :desc)
                  .paginate page: params[:page], per_page: 6
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @relative_news = Post.where(id: Post.pluck(:id).sample(2))
  end

end
