class ContactsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  def index
    respond_to do |format|
      contacts = policy_scope(Contact).joins(:contact).select('users.id, users.name, users.email')
      format.json { 
        render json: 
        {
          status: 0,
          message: "Returned #{contacts.size} contacts",
          data: contacts
        }
      }
    end
  end

  def create
    respond_to do |format|
      contact = Contact.new(contact_params)
      contact.owner_id = current_user.id
      contact.save
      format.json { render json: 
        {
          status: 0,
          message: "Contact was created successfully",
          data: contact 
        }
      }
    end
  end

  def destroy
  end

  private

  def contact_params
    params.require(:contact).permit(
      :contact_id
    )
  end
end
