class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  check_authorization :unless => :devise_controller?
  before_action :set_locale
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  def default_url_options
  { locale: I18n.locale }
  end
end
