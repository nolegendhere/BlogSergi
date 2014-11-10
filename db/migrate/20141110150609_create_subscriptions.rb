class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
		
	  t.integer :user_id

      t.timestamps
    end
    add_index :subscriptions, :user_id
  end
end
