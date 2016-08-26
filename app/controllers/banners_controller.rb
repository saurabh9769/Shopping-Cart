class BannersController < ApplicationController

	def index
		@banners = Banner.all
	end

	def create
  	@banner = Banner.create( banner_params )
	end

	def show
		@banner = Banner.find(params[:id])
	end

	private

	def banner_params
	  params.require(:banner).permit(:image)
	end

end
