class PostsController < ApplicationController

  def index
    @posts = Post.includes(:author).order('created_at DESC').paginate(page: params[:page], per_page: 6)
  end

  def show
    @post = Post.friendly.find(params[:id])
    @posts = @post.author.posts.where.not(slug: params[:id]).order('created_at DESC').limit(6)
  end

  def tests
  end

  def god_post
    time   = Time.zone.now.strftime("%Y-%m-%d")
    params = "http://thanhlinh.net/lich-loi-chua/#{time}"
    doc    = Nokogiri::HTML(open(params).read).css('div[class="view-field view-data-node-title node-title"]//a')
    link   = "http://thanhlinh.net/#{doc.first['href']}"
    @god_post = Nokogiri::HTML(open(link).read).css('div#content-content//div//div.content').to_s
  end

end





#
# def tests
#   params = "https://news.ycombinator.com/best"
#   doc = Nokogiri::HTML(open(params).read).css('[class="storylink"]')
#   link_news = []
#   doc.each do |post|
#     link    = post['href'].include?('http') ? post['href'] : "#{params}/#{post['href']}"
#     link_news << link
#   end
#
#   list_news = []
#   link_news[1..10].each do |news|
#     object = LinkThumbnailer.generate(news)
#     list_news << JSON.parse(object.to_json)
#   end
#
#   @tests = list_news
# end

# url_source = "https://vnexpress.net"
# doc = Nokogiri::HTML(open(url_source).read).css('[id="list_sub_featured"]//li//a:nth-child(1)')
# list_news = []
# doc.each do |post|
#   news = {}
#   link = post['href'].include?('http') ? post['href'] : "#{params}/#{post['href']}"
#   source = Nokogiri::HTML(open(link))
#   description = source.xpath('//meta[@name="description"]')
#   image_url   = source.xpath('//meta[@property="og:image"]')
#   author1     = source.css('p.author_mail strong').empty? ?  nil : source.css('p.author_mail strong').text
#   author2     = source.css('article.content_detail > p[style] > strong').empty? ? nil : source.css('article.content_detail > p[style] > strong').text unless author1
#   author      = author1 || author2 || "Author"
#   news["description"] = description.first ? description.first['content'] : post.text
#   news["link_image"]   = image_url.first ? image_url.first['content'] : "default.png"
#   news["url"] = link
#   news["title"] = post.text
#   news["author"] = author
#   list_news << news
# end
#
# list_news.each do |news|
#   next if news['url'].include?("video.") || news['url'].include?("/infographics/")
#   Author.find_or_create_by!(name: news["author"]).posts.create(title: news['title'], description: news['description'], link_image: news['link_image'], url: news['url'])
# end
