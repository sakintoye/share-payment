class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: [:show, :update, :withdraw, :cancel]
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
    respond_to do |format|
      payment = Payment.new(create_params)
      recipient = User.find_by(id: payment.recipient_id)
      if recipient.present?
        payment.date_sent = DateTime.now
        payment.sender_id = current_user.id
        payment.status = :withdrawn
        if authorize payment
          payment.save
          format.json {
            render json: {
              status: 0,
              message: "You sent a payment to #{recipient.name}",
              payment: payment
            }
          }
        else
          format.json {
            render json: {
              status: 1,
              message: "Payment could not be made"
            }
          }
        end
      else
        format.json {
          render json: {
            status: 1,
            message: "Recipient does not exist"
          },
          status: :not_found
        }
      end
    end
  end

  def show
    respond_to do |format|
      if @payment.present?
        payment = @payment.attributes
        payment[:status] = Payment.statuses[:pending]
        payment[:direction] = set_direction(payment)
        format.json { render json: {
          status: 0,
          payment: payment
         }
        }
      end
    end
  end

  def update
    respond_to do |format|
      authorize @payment
      format.json { render json: @payment }
    end
  end

  def withdraw
    respond_to do |format|
      format.json {
        authorize @payment
        if @payment.date_withdrawn.nil?
          @payment.update_attributes(date_withdrawn: DateTime.now)
          render json: {
            status: 0,
            message: "We have transfered $#{@payment.amount} to your account",
            payment: @payment
          }
        else
          render json: {
            status: 1,
            message: "Looks like this payment had been withdrawn",
            payment: @payment
          }
        end
      }
    end
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

  private

  def set_direction(payment)
    if payment[:sender_id] == current_user.id
      :inbound
    else
     :outbound
    end
  end

  def set_payment
    @payment = Payment.find_by('id= ? AND (recipient_id= ? OR sender_id= ?)', params[:id], current_user.id, current_user.id) or raise ActionController::RoutingError.new('Not Found')
  end

  def create_params
    params.require(:payment).permit(
      :recipient_id, :amount, :reason
    )
  end
end
