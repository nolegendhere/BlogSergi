class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy,:edit, :update]
  #before_action :correct_user,   only: [:destroy,:edit, :update]
  before_action :auth_requirements_one,   only: [:destroy,:edit, :update]
  
  def create
    #@post = Post.find(params[:post_id])
    #@comment = @post.comments.create(comment_params)
    #@comment.user_id = current_user_id
    
    @comment= Comment.create(comment_params)
    @comment.user_id = current_user.id
    @post = Post.find_by_id(comment_params[:post_id])
    @posts = Post.paginate(page: params[:page])
    
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to posts_url
    else
      render 'posts/index'
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to posts_url
  end

  
  def index
    
  end
  
  def edit 
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
   
    if @comment.update(comment_params)
      flash[:success] = "Comment updated"
      redirect_to posts_url
    else
      render 'edit'
    end
  end
  
  private
  
    def comment_params
        params.require(:comment).permit(:content,:post_id)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
    
    def admin?(user)
      if not user.nil?
        return user.admin
      end
        return false
    end
    
    def auth_requirements_one
      @commentuser = current_user.comments.find_by(id: params[:id])
      if admin?(current_user) || current_user?(@commentuser)
        return true
      else
        redirect_to root_url
      end
    end
end


