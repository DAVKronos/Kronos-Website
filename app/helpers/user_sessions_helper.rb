module UserSessionsHelper
  
  def current_user?(user)
    user == current_user
  end
  
  def current_user_session
    @current_user_session ||= UserSession.find
  end
  
  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end
  
  def authenticate
    unless current_user
      store_location
      flash[:notice] = "Hiervoor moet je inloggen, vriend"
      redirect_to new_user_session_path
      return false
    end
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
    
  private
        
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end