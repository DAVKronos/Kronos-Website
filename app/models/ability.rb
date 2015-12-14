class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    merge Abilities::Everyone.new(user)

    if !user.new_record?
      merge Abilities::Authenticated.new(user)
      merge Abilities::Admin.new(user) if user.admin?
    else
      merge Abilities::Guest.new(user)
    end
  end
end
