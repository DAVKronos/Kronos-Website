module Abilities
  class Authenticated
    include CanCan::Ability
    def initialize(user)
      can :read, :all
      can :read, Page
      can :see_email, Commission
      can :create, [Photo, Newsitem, Agendaitem, Event, Result, Comment]
      can [:archief, :wedstrijden, :new_result, :create_result, :icalendar], Agendaitem
      can [:read, :create, :update], [Photoalbum]
      can [:create, :update], [Subscription]
	  cannot :read, Subscription
      can :update, user.agendaitems
	  Subscription.all.where(user: user).each do |subs|
        if !(Agendaitem.find(subs.agendaitem_id).deadline_passed?)
          can :destroy, subs
		end
    end
      if Agendaitem.find_by(name: 'Pilscie Games')
        Result.all.where(event_id:  Event.find_by(agendaitem_id: Agendaitem.find_by(name: 'Pilscie Games').id).id).where(user_id: user.id).each do |res|
          can :destroy, res
        end
      end
      can [:update, :editpassword], user

      cannot :create, User

      if user.active?
        can :manage, user.agendaitems
        user.commissions.each do |com|
          can :update, com.agendaitems
        end
      end

      can :kronometer_list, User if user.kronometer_admin?
      can :manage, Kronometer if user.kronometer_admin?
      can :manage, Result if user.uitslagen_admin?
    end
  end
end
