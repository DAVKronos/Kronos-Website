class Ability
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user (not logged in)
       if user.admin?
         can :manage, :all
       else
         can :read, :all
         can :home, Page
         can :create, UserSession
         cannot :read, User
       end
  end
end
