class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :lastname, :fono, :avatar, :email, :password, :password_confirmation])
		devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :lastname, :fono, :avatar, :email, :password, :password_confirmation, :current_password])
	end

	def authenticate_normal_user!
		redirect_to root_path user_signed_in? && current_user.is_normal_user?
	end

	def authenticate_admin!
		redirect_to root_path unless user_signed_in? && current_user.is_admin_user?
	end
end
