class HomeController < ApplicationController


  def index
		@banner = Banner.all
	  @categories = Category.where( parent_id: nil)
	  @products = Product.per_page_kaminari(params[:page]).per(3)
	  @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
 		# session[:product_ids]
 		@cart = session[:product_ids].count
 	end

 	def addtocart
 		# binding.pry
 		(session[:product_ids] ||= [] ) << params[:product_id]
 		@cart = session[:product_ids].count
 		binding.pry
 	end


end