class AddHeightSToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :height_s, :string
    add_column :characters, :age_s, :string
  end
end
