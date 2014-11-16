class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy,:edit, :update]
  #before_action :correct_user, only: [:destroy,:edit, :update]
  before_action :admin_user, only: [:create,:destroy,:edit, :update]

  def index
    @posts = Post.paginate(page: params[:page])
    @calendar=Calendar.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
       @post.add_to_calendar
       subscriptions_to_email=Subscription.where(subscribed: true)
       #MailNotifier.delay.subscribe_email(subscriptions_to_email,@post)
       #MailNotifier.subscribe_email(subscriptions_to_email,@post).deliver
       MailNotifier.send_subscribe_email(subscriptions_to_email,@post)
       #MailNotifier.delay.send_subscribe_email(subscriptions_to_email,@post)
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post=Post.find(params[:id])
    @post.remove_to_calendar
    @post.destroy
    redirect_to root_url
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Post updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def show
    @post = Post.find(params[:id])
    @calendar=Calendar.all
    if signed_in?
      @comment = current_user.comments.build
    end
  end

  private
  
    def post_params
      params.require(:post).permit(:title,:content,:picture)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
