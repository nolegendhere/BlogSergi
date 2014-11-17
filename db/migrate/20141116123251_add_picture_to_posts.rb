class AddPictureToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :picture, :binary
    add_column :posts, :filename, :string
    add_column :posts, :content_type, :string
    add_column :posts, :description, :string
  end
end
