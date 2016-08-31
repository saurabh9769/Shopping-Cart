class HomeController < ApplicationController


  def index
		@banner = Banner.all
	  @categories = Category.where( parent_id: nil)
	  @products = Product.per_page_kaminari(params[:page]).per(3)
	  @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
 		session[:product_ids] = []
 	end

 	def addtocart
 		session[:product_ids] << params[:product_id]
 		@cart = session[:product_ids].count
 	end


end