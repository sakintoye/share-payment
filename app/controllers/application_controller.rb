class ApplicationController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken

  def user_not_authorized
    respond_to do |format|
      # format.html { redirect_to (request.referrer || root_path), alert: 'Not authorized to perform this action' }
      format.json { render json: {
        status: -1,
        message: "Looks like you're missing permission to perform this action"
      },
      status: :unauthorized }
    end
  end

  def record_not_found
    respond_to do |format|
      # format.html { redirect_to (request.referrer || root_path), alert: 'Not authorized to perform this action' }
      format.json { render json: {
        status: -1,
        message: "Record not found"
      },
      status: :not_found }
    end
  end
end
