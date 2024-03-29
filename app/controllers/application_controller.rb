class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :email
    devise_parameter_sanitizer.for(:account_update) << :email
  end
end
