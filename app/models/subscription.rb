class Subscription < ActiveRecord::Base
  belongs_to :user
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "subscription_id",
                                  dependent:   :destroy
  has_many :posts, through: :active_relationships


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
    posts.include?(post)
  end

end
