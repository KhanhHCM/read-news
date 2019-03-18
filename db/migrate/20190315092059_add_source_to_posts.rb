class AddSourceToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :source, :integer, comment: "1: hack news , other: vnexpres"
  end
end
