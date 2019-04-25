class LoadNewsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(list_news)
    list_news.each do |link|
      data = get_data(link)
      object = LinkThumbnailer.generate(link)
      Author.find_or_create_by!(name: data["author"]).posts.create!(url: link, title: object.title,
                                link_image: object.images.first.src.to_s, description: object.description, source: data["source"], html: data["content"])
    end
  end

private
  def get_data(link)
    data   = {}
    if link.include? "vnexpress"
      source  = Nokogiri::HTML(open(link))
      content = source.css('article.content_detail')
      author1     = source.css('p.author_mail strong').empty? ?  nil : source.css('p.author_mail strong').text
      author2     = source.css('article.content_detail > p[style] > strong').empty? ? nil : source.css('article.content_detail > p[style] > strong').text unless author1
      author      = author1 || author2 || "Author"
      data["content"] = content
      data["author"]  = author
      data["source"]  = 1
      return  data
    else
      data["author"]  = "Author"
      data["source"]  = 99
      return data
    end

  end

end
