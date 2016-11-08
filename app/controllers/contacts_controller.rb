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
      member = Contact.find_by(owner_id: current_user.id, contact_id: contact_params[:contact_id])
      if member.blank?
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
      else
        format.json { render json: 
          {
            status: 0,
            message: "Contact already exists",
            data: member 
          }
        }
      end
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
