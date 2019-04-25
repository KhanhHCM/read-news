class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :html, :text
  end
end
