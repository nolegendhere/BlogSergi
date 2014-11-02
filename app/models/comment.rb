class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { minimum: 5 }
	validates :user_id, presence: true
	validates :post_id, presence: true
end
