class ContactUsController < ApplicationController

	def contact_us
		if params[:name].present?
			@contact_us = ContactUs.create(name: params[:name], email: params[:email], message: params[:message])
			flash[:success] = "You will be contacted shortly!"
			UserMailer.contact_us_mail(@contact_us.email, @contact_us).deliver_now
			redirect_to home_index_path
		end
	end
end
