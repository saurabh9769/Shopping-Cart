class ProductsController < ApplicationController

	def index
		@cart = session[:product_ids].count
		@products = Product.all
	end

	def show
		@cart = session[:product_ids].count
		@product = Product.find(params[:id])
	end

	private

	def product_params
	  params.require(:product).permit(:name, :price, :status, :image)
	end

end
