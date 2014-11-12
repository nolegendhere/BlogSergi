class AddColumnToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :subscribed, :boolean, default: false
  end
end
