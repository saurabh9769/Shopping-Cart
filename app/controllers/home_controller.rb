class HomeController < ApplicationController

	def index
		@banner = Banner.all
		@categories = Category.where( parent_id: nil)
		@products = Product.per_page_kaminari(params[:page]).per(3)
		@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
	end

	def add_to_cart
		session[:product_ids] ||= []
		session[:product_ids] << params[:product_id] if params[:product_id].present?
	end

	# def contact_us
	# 	if params[:name].present?
	# 		@contact_us = ContactUs.create(name: params[:name], email: params[:email], message: params[:message])
	# 		flash[:success] = "You will be contacted shortly!"
	# 		UserMailer.contact_us_mail(@contact_us.email, @contact_us).deliver_now
	# 		redirect_to home_index_path
	# 	end
	# end
end