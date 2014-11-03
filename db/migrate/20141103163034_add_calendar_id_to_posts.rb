class AddCalendarIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :calendar_id, :integer
    add_index :posts, :calendar_id
  end
end
