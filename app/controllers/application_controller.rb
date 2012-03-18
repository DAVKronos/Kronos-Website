class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
  include UserSessionsHelper
  before_filter :prepare_new_session
  
  def prepare_new_session
      @user_session = UserSession.new if !current_user
  end
  
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
  
  
end
