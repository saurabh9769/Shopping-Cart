class AdminsController < ApplicationController

	before_filter :authenticate_admin!
	before_filter :ensure_god_mode

  def ensure_god_mode
    redirect_to rails_admin.index_path("rails_admin") unless current_admin.god_mode?
  end

end
