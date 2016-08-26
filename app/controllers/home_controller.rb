class HomeController < ApplicationController
  def index

		@banner = Banner.all
	  @categories = Category.where(parent_id: nil)

 	end


end