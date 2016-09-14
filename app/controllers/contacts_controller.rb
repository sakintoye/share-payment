class ContactsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  def index
    # @contacts = {name: 'Ola', email: 'sakintoye@gmail.com'}
    respond_to do |format|
      # Contact.create({owner_id: 1, contact_id: 2})
      @contacts = policy_scope(Contact.joins(:user))
      @contacts.each do |contact|
        print "Testing - #{contact.user.name}\n\n"
      end
      format.json { render json: @contacts }
    end
  end

  def create
  end

  def destroy
  end
end
