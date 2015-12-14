module Abilities
  class Admin
    include CanCan::Ability

    def initialize(_)
      can :manage, :all
      can [:update_mailinglists, :update_announcements], User
      cannot :destroy, User
    end
  end
end
