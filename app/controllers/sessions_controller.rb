class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      # session[:session_token] = user.session_token # session and user token now equal
      login!(user)
      redirect_to users_url
    else
      flash[:errors] = ["Invalid Credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout! # calls logout method
    redirect_to new_session_url # redirect to sign in page
  end
  
end
