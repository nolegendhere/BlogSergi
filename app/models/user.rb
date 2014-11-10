class User < ActiveRecord::Base
  #before_save { self.email = email.downcase }
  has_many :posts , dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "user_id",
                                  dependent:   :destroy
  has_many :posts, through: :active_relationships
  


  
  before_save { email.downcase! }
  #with cookies
  #before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 30 }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  
 
  
  def feed
    Post.where("user_id = ?", id)
  end

  # Follows a post.
  def follow(post)
    active_relationships.create(post_id: post.id)
  end

  # Unfollows a post.
  def unfollow(post)
    active_relationships.find_by(post_id: post.id).destroy
  end

  # Returns true if the current user is following the post.
  def following?(post)
    self.posts.include?(post)
  end

#without cookies
  def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

#with cookies
=begin
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
=end

end
