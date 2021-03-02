class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token

  helper_method :current_user, :logged_in?

  def login!(user)
    session[:session_token] = user.reset_session_token!
    # session is a cookie (hash)
    # this saves the users token to the browser
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
    # if session[:session_token] is nil - we dont find a user
  end

  def logged_in?
    !!current_user # returns true if truthy and false if falsey
    # returns true or false, not user object
  end

  def logout!
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil
    @current_user = nil
    # unmatch session_token in every way possible
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
end
