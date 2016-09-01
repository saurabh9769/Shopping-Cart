class HomeController < ApplicationController


  def index
		@banner = Banner.all
	  @categories = Category.where( parent_id: nil)
	  @products = Product.per_page_kaminari(params[:page]).per(3)
	  @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
 	end

 	def addtocart
 		@products = Product.all
 	end

end