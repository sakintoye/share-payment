class PaymentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    respond_to do |format|
    senders = policy_scope(Payment).joins(:sender).select("users.id, users.name, payments.amount, payments.date_sent")
      format.json{ render json: 
        {
          code: 0,
          message: "Returned #{senders.size} record(s)",
          data: senders 
        }
      }
    end
  end

  def sent
    recipients = policy_scope(Sender).joins(:recipient).select("users.id, users.name, payments.amount, payments.date_sent, payments.status")
    respond_to do |format|
      format.json{ render json: 
        {
          code: 0,
          message: "Returned #{recipients.size} record(s)",
          data: recipients 
        }
      }
    end
  end

  def create
  end

  def show
  end

  def update
  end

  def withdraw
  end

  def cancel
    respond_to do |format|
      payment_id = params[:id]
      payment = policy_scope(Sender).find_by(id: payment_id, status: Payment.statuses[:pending])
      unless payment.blank?
        # payment.update_attributes(status: Payment.statuses[:canceled])
      end
      format.json{
        render json:
        {
          payment: payment
        }
      }
    end
  end
end
