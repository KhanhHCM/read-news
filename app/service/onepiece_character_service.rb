class OnepieceCharacterService
  def initialize
    @source = 'https://one-piece.com/'
  end

  def get_chap
    url = 'log/story.html'
    link = full_url(url)
    doc = doc_content(link).css('ul[class="itemList latest active"]/li/a')
    doc.each do |d|
      data = d['href']
      index = data.index('.') - 1
      p data[18..index].tr('_', ' ')
    end
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

  def get_char_info(url)
    doc = full_url(url)
    puts "Getting char's info from is #{doc}"
    # info = doc_content(doc).css('p[class="t middle"]', 'h1[class="t large"]', 'li[class="fl"]')
    info = doc_content(doc).css('li[class="fl"]')
    data = {}
    info.each do |info|
      next if info.blank?
      target = info.text.gsub(/\s+/, "")
      iam = who_am_i(target)
      data.merge!(iam)
    end

    return data
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
    full_url
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

  def who_am_i(data)
    if data.include?('通称')
     return {spec_name: data.tr('通称', '')}
    elsif data.include?('懸賞金')
     return {reward: data.tr('懸賞金', '')}
    elsif data.include?('年齢')
     return {age: data.tr('年齢', '')}
    elsif data.include?('出身地')
     return {birthplace: data.tr('出身地', '')}
    elsif data.include?('身長')
     return {height: data.tr('身長', '')}
    elsif data.include?('好物')
     return {favourite: data.tr('好物', '')}
    elsif data.include?('誕生日')
     return {birthday: data.tr('誕生日', '')}
    else
     {orther: data}
    end
  end

end
