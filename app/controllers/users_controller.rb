class UsersController < ApplicationController
  before_action :require_logged_in, only: [:index]
  
  def index
    # /users
    # gimme all the users
    @users = User.all
    
    # render json: users
    render :index
  end

  def show
    # gimme one specific user
    # user = User.find(params[:id]) # throws exception if cant find user, 
    # exceptions are a pain to deal with
    @user = User.find_by(id: params[:id]) # returns nil if cant find user
    # debugger
    # render json: user
    render :show
  end

  def create
    # create a new instance of user with info from params
    @user = User.new(user_params)

    # attempt to save the user, do something if success, do something if failure
    if @user.save
      # debugger
      # do something
      # redirect_to "/users/#{user.id}" # /users/14 # makes separate GET request to the path provided
      login!(@user)
      redirect_to user_url(@user.id) # same result as above line
    else
      # do something else
      # render json: user.errors.full_messages, status: 422
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def update
    # find existing user using id from params
    @user = User.find_by(id: params[:id])
    # try to update the user, if successful do something, if failure do something else
    if @user.update(user_params)
      redirect_to user_url(@user) # knows to pull the id out of the object
    else
      # render json: user.errors.full_messages, status: 422
      render :edit
    end
  end

  def destroy
    # find existing user by id
    @user = User.find_by(id: params[:id])
    # destroy that user
    @user.destroy
    # render the user that was destroyed
    # render json: user
    redirect_to users_url
  end

  def new
    # common pattern to have access to a blank User instance
    @user = User.new
    # this is optional, Rails (super genius) will know what template you want to render
    render :new
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :age, :political_affiliation, :password)
  end

end