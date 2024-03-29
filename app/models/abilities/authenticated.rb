module Abilities
  class Authenticated
    include CanCan::Ability
    def initialize(user)
      can :read, :all
      can :read, Page
      can :see_email, Commission
      can :create, [Photo, Newsitem, Agendaitem, Event, Result, Comment]
      can [:archief, :wedstrijden, :new_result, :create_result, :icalendar, :duplicate], Agendaitem
      can [:read, :create, :update], [Photoalbum]
      can [:create, :update], [Subscription], user_id: user.id
      can :display, Kronometer
      can :update, Agendaitem, user_id: user.id
      Subscription.all.where(user: user).each do |sub|
          if !(Agendaitem.find(sub.agendaitem_id).deadline_passed?)
            can :destroy, Subscription, id:sub.id
          end
      end
      
      can [:update, :editpassword], User, id: user.id

      can :birthdays, User
      cannot :create, User

      if user.active?
        can :manage, Agendaitem, user_id: user.id
        user.commissions.each do |com|
          can :update, Agendaitem, commission_id: com.id
        end
      end

      can :kronometer_list, User if user.kronometer_admin?
      can :manage, Kronometer if user.kronometer_admin?
      can :manage, Result if user.uitslagen_admin?
    end
  end
end
