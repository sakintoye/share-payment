class MembersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    members = User.all.where.not(id: current_user.id)
    respond_to do |format|
      format.json { render json:
        {
          status: 0,
          members: members
        }
      }
    end
  end

  def show
    members = User.find_by(id: params[:id]) or raise ActionController::RoutingError.new('Not Found')
    respond_to do |format|
      format.json { render json:
        {
          status: 0,
          members: members
        }
      }
    end
  end

  def block_user
  end
end
