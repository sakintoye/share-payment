class SendgridMailer < ActionMailer::Base

  def email(to, subject, body)
    mail(:to => to, :from => Rails.application.config.x.email_from, :subject => subject) do |format|
      format.text { render :text => body }
      format.html { render :text => body }
    end
  end
end