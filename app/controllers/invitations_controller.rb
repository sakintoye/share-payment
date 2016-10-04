class InvitationsController < ApplicationController
  skip_before_action :authenticate_user!
  respond_to :json
  
  def create
  	respond_to do |format|
	  	email = param_create[:email]
	  	user = User.find_by(uid: email)
	  	if user.blank?
	  		invitation = {invite_mode: "mobile", sender_id: current_user.id, contact_info: email, status: true}
	  		if !Invitation.exists(current_user.id, email)
	  			Invitation.create(invitation)
	  			to = email
	  			subject = "Invitation from #{current_user.name}"
	  			body = "Hi, #{current_user.name} sent you an invitation to try #{Rails.application.config.x.app_name}."
	  			SendgridMailer.email(to, subject, body).deliver_now
				format.json{ render json: 
					{
						status: 0,
						messgae: 'Invitation was sent successfully',
						invitation: invitation
					}.to_json
				}
			else
				format.json{ render json: 
					{
						status: 1,
						messgae: "You have already sent an invitation to #{email}"
					}.to_json
				}
			end
		else
			format.json{
				render json: {
					status: 1,
					message: "User with email #{email} is already a member",
				}.to_json
			}
			
		end

  	end

  end

  private

  def param_create
  	params.require(:invitation).permit(
      :email
    )
  end
end
