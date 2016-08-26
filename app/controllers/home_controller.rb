class HomeController < ApplicationController
  def index

		@banner = Banner.all
		# @category = Category.all
	  @categories = Category.where(parent_id: nil)
	  # binding.pry
	  # @categories = @category.subcategories.build
	 #  @check = ''
		# @cnt = 0

 	end


end