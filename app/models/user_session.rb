class UserSession < Authlogic::Session:Base
  def to_key
    [session_key]
    end
end
