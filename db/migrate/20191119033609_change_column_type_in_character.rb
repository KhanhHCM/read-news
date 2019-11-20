class ChangeColumnTypeInCharacter < ActiveRecord::Migration[5.2]
  def change
    change_column :characters, :birthday, :string
  end
end
