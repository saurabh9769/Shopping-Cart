class ProductImagesController < ApplicationController

	def index
		@productimages = ProductImage.all
	end

	def create
  	@productimage = ProductImage.create( image_params )
	end

	def show
		@productimage = ProductImage.find(params[:id])
	end

	private

	def image_params
	  params.require(:productimage).permit(:image)
	end

end
