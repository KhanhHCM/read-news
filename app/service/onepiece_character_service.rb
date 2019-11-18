class OnepieceCharacterService
  def initialize
    @source = 'https://one-piece.com/'
  end

  def get_character(get_single)
    url = 'log/character.html'
    if get_single
      single_page(url)
    else
      limit_page = limit_page(url)
      for i in 1..limit_page do
        single_page(url + "?p=#{i}")
      end
    end

  end

  def load_fruits
    url = 'log/character/devilfruit.html'
    limit_page = limit_page(url)
    for i in 1..limit_page do
      load_fruit(url + "?p=#{i}")
    end
  end


private

  def load_fruit(url)
    doc = full_url(url)
    puts "Loading fruit from is #{doc}"
    characters = doc_content(doc).css('a[class="boxRadius"]')
    characters.each do | c |
      data = []
      data << c['href']
      data << c.css('p[class="f13 t subComment"]').text
      apply_fruit(data)
    end
  end

  def single_page(url)
    doc = full_url(url)
    puts "Getting from is #{doc}"
    urls = doc_content(doc).css('a[class="boxRadius"]/@href')
    urls.each do |url|
      save_to_db(url.text)
    end
  end

  def full_url(url)
    full_url = @source + url
    return full_url
  end

  def limit_page(url)
    doc = full_url(url)
    last_page_url = doc_content(doc).css('li[class="end"]//a/@href').text
    last_page = last_page_url.from(last_page_url.index('p=') + 2)
    return last_page.to_i
  end

  def doc_content(doc)
    Nokogiri::HTML(open(doc).read)
  end

  def save_to_db(url)
    Character.find_or_create_by(url: url)
  end

  def apply_fruit(data)
    character = Character.find_or_create_by(url: data[0])
    character.update(devilfruit: data[1])
  end

end
