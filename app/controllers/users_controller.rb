class UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  def me
    profile = User.find_by(id: current_user.id)
    render json: profile
  end
end
