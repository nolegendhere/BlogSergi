class Relationship < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :post

  validates :subscription_id, presence: true
  validates :post_id, presence: true

end
