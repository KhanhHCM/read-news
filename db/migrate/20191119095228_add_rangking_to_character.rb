class AddRangkingToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :ranking, :integer
  end
end
