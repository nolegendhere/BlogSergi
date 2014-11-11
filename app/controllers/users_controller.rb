class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :admin_user,  only: [:destroy]
  #before_action :correct_user,   only: [:edit, :update]
  before_action :auth_requirements_one,   only: [:edit, :update]

  
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      @user.add_subscription
      #without delay
      MailNotifier.registered(@user).deliver
      #trying delay
      #MailNotifier.delay.registered(@user)
      flash[:success] = "Welcome to the Blog Sergi!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin?(user)
      if not user.nil?
        return user.admin
      end
        return false
    end
    
    def auth_requirements_one
      @actualuser = User.find(params[:id])
      if admin?(current_user) || current_user?(@actualuser)
        return true
      else
        redirect_to root_url
      end
    end
    
   
end
