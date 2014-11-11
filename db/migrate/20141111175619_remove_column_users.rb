class RemoveColumnUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :subscribed, :boolean
  end
end
