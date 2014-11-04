class CalendarsController < ApplicationController
	def show
		@posts = Calendar.find(params[:id]).feed_calendar.paginate(page: params[:page])
		#.posts.where("calendar_id = ?", id).paginate(page: params[:page])
		#@posts = Calendar.feed_calendar.paginate(page: params[:page])
		@calendar=Calendar.all
	end
end
