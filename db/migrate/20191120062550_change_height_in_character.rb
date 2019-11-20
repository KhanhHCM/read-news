class ChangeHeightInCharacter < ActiveRecord::Migration[5.2]
  def change
    change_column :characters, :height, 'integer USING CAST(height AS integer)'
  end
end
