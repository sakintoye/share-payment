class MembersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    members = User.all.where(registration_status: 1).where.not(id: current_user.id)
    respond_to do |format|
      format.json { render json:
        {
          status: 0,
          data: members
        }
      }
    end
  end

  def show
    member = User.find_by(id: params[:id]) or raise ActionController::RoutingError.new('Not Found')
    respond_to do |format|
      format.json { render json:
        {
          status: 0,
          data: member
        }
      }
    end
  end

  def block_user
  end
end
