class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :calendar
	has_many :comments, dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "post_id",
                                   dependent:   :destroy
  has_many :subscriptions, through: :passive_relationships
	default_scope -> { order('created_at DESC') }
	#scope :by_month, where()
	validates :title, presence: true
	validates :content, presence: true
	validates :user_id, presence: true

	def add_to_calendar
    Calendar.where(post_month: ((self.created_at).to_date).mon).each do |calendar|
      if calendar.post_year == ((self.created_at).to_date).year
        calendar.post_numberof+=1
        calendar.save
        self.calendar_id=calendar.id
        self.save
        return
      end
    end
    
    calendar=Calendar.new
    calendar.post_numberof=1
    calendar.post_year=((self.created_at).to_date).year
    calendar.post_month=((self.created_at).to_date).mon
    calendar.save
    self.calendar_id=calendar.id
    self.save
    return
  end

  def remove_to_calendar
    Calendar.where(post_month: ((self.created_at).to_date).mon).each do |calendar|
      if calendar.post_year == ((self.created_at).to_date).year
        calendar.post_numberof-=1
        if calendar.post_numberof==0
          calendar.destroy
          return
        else
          calendar.save
          return
        end
      end
    end
  end

  def upload(params)
    uploaded_io = params[:filename]
    #uploaded_io = params[:piture][:filename]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    self.filename=uploaded_io.original_filename
  end

=begin
  def upload
    redirect_to "index"
    uploaded_io = params[:filename]
    self.filename=uploaded_io.original_filename
  end
=end
=begin
  def upload
    uploaded_io = params[:filename]
    #uploaded_io = params[:piture][:filename]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    self.filename=uploaded_io.original_filename
  end
=end
=begin
  def upload
    uploaded_io = params[:filename].original_filename
    #uploaded_io = params[:piture][:filename]
    File.open(Rails.root.join('public', 'uploads', uploaded_io), 'wb') do |file|
      file.write(params[:filename].read)
    end 
  end
=end
end
