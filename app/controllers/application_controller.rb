class ApplicationController < ActionController::Base
  protect_from_forgery
  include UserSessionsHelper
  rescue_from Acl9::AccessDenied, :with => :acl_error
  before_filter :prepare_new_session
  
  def prepare_new_session
      @user_session = UserSession.new if !current_user
  end
  
  def acl_error
    redirect_to :root
    flash[:warning] = "Toegang verboden"
  end
  
  
end
