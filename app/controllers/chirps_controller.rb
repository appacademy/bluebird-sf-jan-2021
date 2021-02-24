class ChirpsController < ApplicationController
  def index
    # /users/:user_id/chirps
    user = User.find_by(id: params[:user_id])
    chirps = user.chirps

    render json: chirps
  end
end
