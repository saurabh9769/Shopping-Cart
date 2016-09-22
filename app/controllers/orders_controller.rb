class OrdersController < ApplicationController

	def checkout

		if user_signed_in?
			redirect_to orders_checkout_path
		else
			redirect_to user_session_path
		end

	end

end
