class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

  	def after_sign_in_path_for(user)

			if current_user.present?
				root_path
			else
		  	new_user_session_path
			end

			# binding.pry
		end

		def after_sign_in_path_for(admin)
			if current_admin.god_mode?
				rails_admin.index_path('rails_admin')
			else
				new_admin_session_path
			end
		end

	protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
	  end

end
