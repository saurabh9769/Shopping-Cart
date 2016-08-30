class ProductsController < ApplicationController

	def index
	end

	def show
		@products = Product.all
	end

	private

	def product_params
	  params.require(:product).permit(:name, :price, :status)
	end

end
