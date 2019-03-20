class AddUniqueIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, [:url, :slug], unique: true
  end
end
