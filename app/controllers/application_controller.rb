class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?

	protected

	def configure_devise_permitted_parameters
    	registration_params = [:name, :email, :password, :password_confirmation]

	    if params[:action] == 'create'
	    	devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
	    elsif params[:action] == 'update'
	    	devise_parameter_sanitizer.permit(:account_update, keys: registration_params)
	    end
	end
end
