class AddColumnToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :group, :string
    add_column :characters, :spec_name, :string
    add_column :characters, :orther, :string
  end
end
