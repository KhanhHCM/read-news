namespace :character do
  desc "Get more char infomation"
  task get_from_pixiv: :environment do
    Character.where.not(pixiv_link: nil).each do |c|
      c.get_pixiv
    end
  end

end
