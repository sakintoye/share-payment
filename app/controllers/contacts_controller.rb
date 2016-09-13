class ContactsController < ApplicationController
  # before_action :authenticate_user!
  respond_to :json
  def index
    @contacts = {name: 'Ola', email: 'sakintoye@gmail.com'}
    respond_to do |format|
      format.json { render json: @contacts }
    end
  end

  def create
  end

  def destroy
  end
end
