class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(user)
		if resource.class == User
			if current_user.present?
				stored_location_for(user) || root_url
			else
			  new_user_session_path
			end
		elsif resource.class == Admin
			if current_admin.present?
				rails_admin.index_path('rails_admin')
			else
				new_admin_session_path
			end
		end
	end

	def after_sign_up_path_for(user)
		home_index_path
	end

	private

  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) do |user_params|
  		user_params.permit(:email, :password, :password_confirmation)
		end

		devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }

		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password) }
	end

end
