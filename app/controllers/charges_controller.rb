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
			transaction = Transaction.create(order_id: params[:order_id], totalvalue: params[:totalvalue], stripe_token: params[:stripeToken], stripe_token_type: params[:stripeTokenType], stripe_email: params[:stripeEmail])
			Order.where(id: params[:order_id]).update_all(status: 1, grand_total: params[:totalvalue], transaction_id: transaction.id)
			@order = Order.where(id: params[:order_id])
			UserMailer.order_confirmation(current_user, @order).deliver_now
			OrderDetail.where(order_id: params[:order_id]).update_all(amount: params[:totalvalue])
			session[:product_ids] = nil
	  end

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to new_charge_path
	end
end