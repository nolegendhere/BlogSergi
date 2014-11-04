class Calendar < ActiveRecord::Base
	has_many :posts

	def feed_calendar
	    Post.where("calendar_id = ?", id)
	end
end
