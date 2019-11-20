class ChangeRankingInCharacter < ActiveRecord::Migration[5.2]
  def change
    change_column :characters, :ranking, :decimal
  end
end
