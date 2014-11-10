class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|

      t.integer :subscription_id
      t.integer :post_id

      t.timestamps
    end
    add_index :relationships, :subscription_id
    add_index :relationships, :post_id
    add_index :relationships, [:subscription_id, :post_id], unique: true
  end
end
