class AdminsController < ApplicationController

	# before_filter :authenticate_admin!
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(admin)
		if current_admin.present?
			rails_admin.index_path('rails_admin')
		else
			new_admin_session_path
		end
	end

	def after_sign_up_path_for(admin)
		rails_admin.index_path('rails_admin')
	end

	private

 	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) do |admin_params|
			admin_params.permit(:email, :password, :password_confirmation)
		end

		devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
	end

end
