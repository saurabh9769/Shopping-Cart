class HomeController < ApplicationController
  def index

		@banner = Banner.all
	  @categories = Category.where( parent_id: nil)
	  binding.pry
	  if ( "#{params[:category_id]}".present?)
	  	@product_category = Product.joins(:category).where( "products.category_id = #{params[:category_id]}" )
	  else
	  	@product_category = Product.joins(:category).where("products.category_id = categories.id")
	  end

 	end


end