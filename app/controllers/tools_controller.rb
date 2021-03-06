class ToolsController < ApplicationController

  def new
    new_price = [1678, 1734, 2014, 2536, 2834, 2927]
    old_price = [1549, 1600, 1858, 2340, 2615, 2710]
    lv = ["0~50", "51~100", "101~200", "201~300", "301~400", "401~"]
    per_up = []
    t = 0
    new_price.each do |n|
      per_up << percent_up(n, old_price[t])
      t+= 1
    end

    @data = []
    (0..5).each do |n|
      @data << {
        new_price: new_price[n],
        old_price: old_price[n],
        lv:        lv[n],
        per_up:    per_up[n],
        rank:      n
      }
    end
  end

  def tax
    lv = [*1..7]
    explan = ["Dưới 5", "Từ 5 ~ 10", "Từ 10 ~ 18", "Từ 18 ~ 32", "Từ 32 ~ 52", "Từ 52 ~ 80", "Trên 80"]
    per = [*5..35].select { |a| a%5 == 0}
    @data = []
    (0..7).each do |n|
      @data << {
        lv: lv[n],
        explan: explan[n],
        per:        per[n],
      }
    end

  end

  private
  def percent_up(new_price, old_price)
    ((new_price - old_price).fdiv old_price)*100
  end

end
