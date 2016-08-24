class HomeController < ApplicationController
  def index
	@banner = Banner.all
  end
end
