module Abilities
  class Authenticated
    include CanCan::Ability
    def initialize(user)
      can :read, :all
      can :see_email, Commission
      can :create, [Photo, Newsitem, Agendaitem, Event, Result]
      can [:archief, :wedstrijden, :new_result, :create_result], Agendaitem
      can [:read, :create, :update], [Photoalbum, Subscription]
      can :update, user.agendaitems
      can :destroy, [user.subscriptions, user.chatmessages]
      can [:update, :editpassword], user

      cannot :create, User

      user.chatmessages.each do |chatmessage|
        can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
      end

      if user.active?
        can :manage, user.agendaitems
        user.commissions.each do |com|
          can :update, com.agendaitems
        end
      end

      can :manage, Kronometer if user.kronometer_admin?
      can :manage, Result if user.uitslagen_admin?
    end
  end
end
