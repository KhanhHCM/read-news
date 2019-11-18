class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :reward
      t.string :devilfruit
      t.integer :fruit_type
      t.integer :age
      t.string :birthplace
      t.string :height
      t.string :favourite
      t.date :birthday
      t.text :url
      
      t.timestamps
    end
  end
end
