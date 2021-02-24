class UsersController < ApplicationController
  
  def index
    # /users
    # gimme all the users
    users = User.all
    
    render json: users
  end

  def show
    # gimme one specific user
    # user = User.find(params[:id]) # throws exception if cant find user, 
    # exceptions are a pain to deal with
    user = User.find_by(id: params[:id]) # returns nil if cant find user

    render json: user
  end

  def create
    # create a new instance of user with info from params
    user = User.new(user_params)

    # attempt to save the user, do something if success, do something if failure
    if user.save
      debugger
      # do something
      # redirect_to "/users/#{user.id}" # /users/14 # makes separate GET request to the path provided
      redirect_to user_url(user.id) # same result as above line
    else
      # do something else
      render json: user.errors.full_messages, status: 422
    end
  end

  def update
    # find existing user using id from params
    user = User.find_by(id: params[:id])
    # try to update the user, if successful do something, if failure do something else
    if user.update(user_params)
      redirect_to user_url(user) # knows to pull the id out of the object
    else
      render json: user.errors.full_messages, status: 422
    end
  end

  def destroy
    # find existing user by id
    user = User.find_by(id: params[:id])
    # destroy that user
    user.destroy
    # render the user that was destroyed
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :age, :political_affiliation)
  end

end