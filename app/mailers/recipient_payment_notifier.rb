class RecipientPaymentNotifier < ApplicationMailer
	default from: 'no-reply@sharepayment.com'

	def send_notification(user)
		@user = user
		mail(to: @user.email, subject: 'A payment was transfered to you!')
	end
end