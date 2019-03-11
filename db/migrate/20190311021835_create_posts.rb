class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :link_image

      t.timestamps
    end
  end
end
