class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    post = Post.find(params[:post_id])
    current_user.subscription.follow(post)
    redirect_to post
  end

  def destroy
    post = Relationship.find(params[:id]).post
    current_user.subscription.unfollow(post)
    redirect_to post
  end



end
