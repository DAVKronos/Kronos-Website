class ApplicationController < ActionController::Base
  protect_from_forgery
  include UserSessionsHelper
  before_filter :prepare_new_session
  
  def prepare_new_session
      @user_session = UserSession.new if !current_user
  end
end
