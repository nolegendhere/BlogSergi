class RemoveTimestampsFromRelationships < ActiveRecord::Migration
  def change
    remove_column :relationships, :created_at, :string
    remove_column :relationships, :updated_at, :string
  end
end
