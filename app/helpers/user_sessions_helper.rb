module UserSessionsHelper
  
def current_user?(user)
  user == current_user
end

end