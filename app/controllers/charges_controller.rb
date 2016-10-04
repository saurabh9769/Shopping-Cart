class ChargesController < ApplicationController
	def new
		@amount = params[:totalvalue]
		@order = Order.find(params[:order_id])
	end

	def create
		@amount = params[:totalvalue].to_i * 100
	  customer = Stripe::Customer.create(
	    :email => params[:stripeEmail],
	    :source  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'inr'
	  )

	  if charge["paid"] == true
			Order.where(id: params[:order_id]).update_all(status: 1, grand_total: params[:totalvalue])
			Transaction.create(order_id: params[:order_id], totalvalue: params[:totalvalue], stripe_token: params[:stripeToken], stripe_token_type: params[:stripeTokenType], stripe_email: params[:stripeEmail])
			OrderDetail.where(order_id: params[:order_id]).update_all(amount: params[:totalvalue])
	  end

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end
end