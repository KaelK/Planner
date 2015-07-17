class ApplicationController < ActionController::Base
         

        def update_sanitized_params
          devise_parameter_sanitizer.for(:sign_up){ |u| u.permit(:first_name, :last_name, :site_link, :password, :password_confirmation, :email)}
        end

        def after_sign_in_path_for(user)
          users_path
        end

  before_filter :update_sanitized_params, if: :devise_controller?
  protect_from_forgery with: :exception
end
