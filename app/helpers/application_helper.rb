module ApplicationHelper

  def logout_path
    if defined?(Devise)
      scope = Devise::Mapping.find_scope!(_current_user)
      main_app.send("destroy_#{scope}_session_path") rescue false
    elsif main_app.respond_to?(:logout_path)
      main_app.logout_path
    end
  end

  def logout_method
    return [Devise.sign_out_via].flatten.first if defined?(Devise)
    :delete
  end

end
