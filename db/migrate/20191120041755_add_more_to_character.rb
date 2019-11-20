class AddMoreToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :haki, :string
    add_column :characters, :weapon, :string
  end
end
