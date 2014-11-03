class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :calendar
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	#scope :by_month, where()
	validates :title, presence: true
	validates :content, presence: true
	validates :user_id, presence: true
#=begin
	def add_to_calendar
      Calendar.where(post_month: ((self.created_at).to_date).mon).each do |calendar|
        if calendar.post_year == ((self.created_at).to_date).year
          self.calendar_id=calendar.id
          calendar.post_numberof+=1
          calendar.save
          self.save
          return
        end
      end
      
      calendar=Calendar.new
      self.calendar_id=calendar.id
      calendar.post_numberof=1
      calendar.post_year=((self.created_at).to_date).year
      calendar.post_month=((self.created_at).to_date).mon
      calendar.save
      self.save
      return
    end
#=end
end
