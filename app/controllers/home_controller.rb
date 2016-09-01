class HomeController < ApplicationController


  def index
		@banner = Banner.all
	  @categories = Category.where( parent_id: nil)
	  @products = Product.per_page_kaminari(params[:page]).per(3)
	  @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
 	end


	def addtocart
		@products = Product.all #just for temporary purpose
		(session[:product_ids] ||= []) << params[:product_id] if params[:product_id].present?
		@cart = session[:product_ids].count
	end

end