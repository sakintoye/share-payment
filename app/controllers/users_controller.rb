class UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  def me
    profile = User.all
    render json: profile
  end
end
