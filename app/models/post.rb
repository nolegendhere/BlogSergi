class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	#scope :by_month, where()
	validates :title, presence: true
	validates :content, presence: true
	validates :user_id, presence: true
end
