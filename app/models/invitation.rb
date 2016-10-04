class Invitation < ActiveRecord::Base
	def self.exists(sender_id, contact_info)
		invite = Invitation.find_by(sender_id: sender_id, contact_info: contact_info)
		invite.present?
	end
end
