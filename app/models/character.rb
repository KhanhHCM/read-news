class Character < ApplicationRecord

  def get_pixiv
    data = CrawlPixivService.new.op_character(self.pixiv_link)
    if data.present?
      self.update(data)
    else
      self.destroy
    end
  end

  # def get_pixiv
  #   data = CrawlPixivService.new.remove_if_notfound(self.pixiv_link)
  #   self.destroy unless data.present?
  # end

  def get_more_info
    data = OnepieceCharacterService.new.get_char_info(self.url)
    index = self.url.index('.') - 1
    romaji = self.url[22..index].tr('_', ' ')
    data.merge!({romaji_name: romaji})
    self.update(data)
  end

  def conver_to_integer
    oku = '億'
    man = '万'
    data = self.reward
    if data.include?(oku) && data.include?(man)
      index1 = data.index(oku)
      index2 = data.index(man)
      re1 = to_oku(data[0..index1])
      re2 = to_man(data[(index1 + 1)..(index2 - 1)])
      re = re1 + re2
    elsif data.include?(oku)
      index = data.index(oku)
      re = to_oku(data[0..index])
    elsif data.include?(man)
      index = data.index(man)
      re = to_man(data[0..index])
    else
      re = data.delete('.').to_i * 0.000001
    end

    self.update(ranking: re)

  end

  def remove_moto
    moto = '元'
    new_reward = self.reward.delete(moto)
    self.update(reward: new_reward)
  end

private

  def to_oku(number)
    number.to_i * 100
  end

  def to_man(number)
    number.to_i * 0.01
  end

end
