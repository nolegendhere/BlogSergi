module SessionsHelper

#with cookies
=begin
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end


  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

=end

#without cookies
#=begin
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
  end

  def sign_out
    session.delete(:user_id)
      @current_user = nil
  end
#=end  
  def signed_in?
    !current_user.nil?
  end
  
   def current_user=(user)
    @current_user = user
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  
  def admin_user
    if current_user.admin?
      return true
    else
      redirect_to(root_url)
    end
      #redirect_to(root_url) unless current_user.admin?
  end
    
end
