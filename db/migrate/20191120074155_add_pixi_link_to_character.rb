class AddPixiLinkToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :pixiv_link, :string
  end
end
