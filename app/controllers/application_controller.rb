class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :configure_devise_permitted_parameters, if: :devise_controller?

	rescue_from ActionController::RoutingError, with: :render_404
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

	protected

	def configure_devise_permitted_parameters
    	registration_params = [:name, :email, :password, :password_confirmation, :avatar]

	    if params[:action] == 'create'
	    	devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
	    elsif params[:action] == 'update'
	    	devise_parameter_sanitizer.permit(:account_update, keys: registration_params)
	    end
	end

	def render_404
    	render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout => false
  	end

  	def record_not_found(exception)
  		p exception
  		#logging
  	end
end
