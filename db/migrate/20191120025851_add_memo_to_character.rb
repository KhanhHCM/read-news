class AddMemoToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :memo, :text
  end
end
