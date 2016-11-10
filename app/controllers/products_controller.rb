class ProductsController < ApplicationController

	def index
		@products = Product.all.order("created_at ASC")
	end

	def show
		@product = Product.find(params[:id])
	end

	def import
		Product.import(params[:file])
		redirect_to products_path, notice: "Products imported."
	end

	private

	def product_params
	  params.require(:product).permit(:name, :price, :status, :image)
	end

end
