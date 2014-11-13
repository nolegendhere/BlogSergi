class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy,:edit, :update]
  #before_action :correct_user, only: [:destroy,:edit, :update]
  before_action :auth_requirements_one, only: [:destroy,:edit, :update]


  def create
    @comment= Comment.create(comment_params)
    @comment.user_id = current_user.id
    @post = Post.find_by_id(comment_params[:post_id])
    @calendar=Calendar.all
    respond_to do |format|
      if @comment.save
        @subscriptions_to_email=@post.subscriptions
        #MailNotifier.delay.follow_email(@subscriptions_to_email,@post)
        #MailNotifier.follow_email(@subscriptions_to_email,@post).deliver
        MailNotifier.send_follow_email(@subscriptions_to_email,@post)
        #MailNotifier.delay.send_follow_email(@subscriptions_to_email,@post)
        format.html { 
          flash[:success] = "Comment created!"
          redirect_to @post
        }
      else
        format.html {
          render 'posts/show'
        }
      end
      format.js
    end
  end

  def destroy
    @comment=Comment.find(params[:id])
    @post= Post.find_by_id(@comment.post_id)
    @comment.destroy
    respond_to do |format|
      format.html {
        redirect_to @post
      }
      format.js
    end
  end

  def index
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @post= Post.find_by_id(@comment.post_id)
    @calendar=Calendar.all
    if @comment.update(comment_params)
      flash[:success] = "Comment updated"
      redirect_to @post
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
      @comment= current_user.comments.find_by(id: params[:id])
      @commentuser = User.find_by(id: @comment.user_id)
      if admin?(current_user) || current_user?(@commentuser)
        return true
      else
        redirect_to root_url
      end
    end
end


