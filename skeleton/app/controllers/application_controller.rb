class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_token!
    @current_user = user
  end

  def logout(user)
    current_user.session_token.reset_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
