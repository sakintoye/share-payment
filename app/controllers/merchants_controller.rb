class MerchantsController < ApplicationController
	require "stripe"
	skip_before_filter  :verify_authenticity_token
	respond_to :json

	Stripe.api_key = Rails.application.secrets.stripe_key

	def charge  #post
	  authenticate!
	  # Get the credit card details submitted by the form
	  source = params[:source]

	  # Create the charge on Stripe's servers - this will charge the user's card
	  begin
	    charge = Stripe::Charge.create(
	      :amount => params[:amount], # this number should be in cents
	      :currency => "usd",
	      :customer => @customer.id,
	      :source => source,
	      :description => "Example Charge"
	    )
		render json: "Charge successfully created", status: 200
		rescue Stripe::StripeError => e
		render json: "Error creating charge: #{e.message}", status: 402
		return
	  end
	end

	def customer  #get
		authenticate!
		render json: @customer 
	end

	def customer_sources #post
	  authenticate!
	  source = params[:source]

	  # Adds the token to the customer's sources
	  begin
	    @customer.sources.create({:source => source})
	  rescue Stripe::StripeError => e
	    render json: "Error adding token to customer: #{e.message}", status: 402
	    return
	  end
	  render json: "Successfully added source."
	end

	def customer_default_source
	  authenticate!
	  source = params[:source]

	  # Sets the customer's default source
	  begin
	    @customer.default_source = source
	    @customer.save
	  rescue Stripe::StripeError => e
	    render json: "Error selecting default source: #{e.message}", status: 402
	    return
	  end

	  render json: "Successfully selected default source."
	end

	def authenticate!
	  # This code simulates "loading the Stripe customer for your current session".
	  # Your own logic will likely look very different.
	  return @customer if @customer
	  if params.has_key?(:customer_id)
	    customer_id = params[:customer_id]
	    begin
	      @customer = Stripe::Customer.retrieve(customer_id)
	    rescue Stripe::InvalidRequestError
	    end
	  else
	    begin
	      @customer = Stripe::Customer.create(:description => "Share Payment")
	    rescue Stripe::InvalidRequestError
	    end
	    session[:customer_id] = @customer.id
	  end
	  @customer
	end

	# This endpoint is used by the Obj-C example to complete a charge.
	def charge_card
	  # Get the credit card details submitted by the form
	  token = params[:stripe_token]

	  # Create the charge on Stripe's servers - this will charge the user's card
	  begin
	    charge = Stripe::Charge.create(
	      :amount => params[:amount], # this number should be in cents
	      :currency => "usd",
	      :card => token,
	      :description => "Example Charge"
	    )
	  rescue Stripe::StripeError => e
	    render json: "Error creating charge: #{e.message}", status: 402
	    return 
	  end

	  render json: "Charge successfully created", status: 200
	end

	def webhook
		render json: "Webhook is working :)", status: 200
	end
end
