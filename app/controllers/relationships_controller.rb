class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @post = Post.find(params[:post_id])
    current_user.subscription.follow(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @post = Relationship.find(params[:id]).post
    current_user.subscription.unfollow(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end



end
