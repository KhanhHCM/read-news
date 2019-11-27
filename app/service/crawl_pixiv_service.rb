class CrawlPixivService
  def initialize
    @source = 'https://dic.pixiv.net/a/%E6%B5%B7%E8%B3%8A%28ONEPIECE%29'
  end

  def op_character(url)
    doc = doc_content(url).present? ? doc_content(url).css('tr') : nil
    atr_update = {}
    if doc.present?
      doc.each do |d|
        data = []
        data << d.css('th').text
        data << d.css('td').text
        col = check_cloumn_info(data)
        atr_update.merge!(col) if col.present?
      end
      atr_update
    else
      return nil
    end

  end

  def get_char_link
    doc = doc_content(@source).css('p//b//a')
    if doc.present?
      doc.each do |d|
        data = [d['href'], d.text]
        save_to_db(data)
      end
    end
  end

  def remove_if_notfound(url)
    doc = doc_content(url)
    data = doc.present? ? doc.css('tr') : nil
    data
  end


  private

  def doc_content(doc)
    begin
      puts "Getting from #{doc}"
      Nokogiri::HTML(open(doc).read)
    rescue => exception
      p exception.to_s
      return nil
    end
  end

  def save_to_db(data)
    c = Character.find_or_create_by(name: data[1])
    c.update(pixiv_link: data[0])
  end

  def check_cloumn_info(info)
    case info[0]
    when /本名/
      {name: info[1]}
    when /異名/
      {spec_name: info[1]}
    when /年齢/
      {age_s: info[1]}
    when /身長/
      {height_s: info[1]}
    when /懸賞金/
      {reward: info[1]}
    when /所属/
      {group: info[1]}
    when /悪魔の実/
      {devilfruit: info[1]}
    when /覇気/
      {haki: info[1]}
    when /出身地/
      {birthplace: info[1]}
    when /誕生日/
      {birthday: info[1]}
    when /武器/
      {weapon: info[1]}
    else
      puts 'no match'
    end
  end

end
