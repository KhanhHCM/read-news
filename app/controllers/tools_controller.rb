class ToolsController < ApplicationController

  def new
  end

  def estimate
  end

  def sum(consum)
    price1 = 1678
    price2 = 1734
    price3 = 2014
    price4 = 2536
    price5 = 2834
    price6 = 2927

    lv1 = price1*50
    lv2 = lv1 + price2*50
    lv3 = lv2 + price3*100
    lv4 = lv3 + price4*100
    lv5 = lv4 + price5*100

    case consum
    when 1..50
      consum * price1
    when 51..100
      lv1 + (consum - 50)*price2
    when 100..200
      lv2 + (consum - 100)*price3
    when 200..300
      lv3 + (consum - 200)*price4
    when 300..400
      lv4 + (consum - 300)*price5
    else
      lv5 + (consum - 400)*price6
    end
  end

end
