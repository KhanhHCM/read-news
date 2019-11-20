class AddRomajiToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :romaji_name, :string
  end
end
