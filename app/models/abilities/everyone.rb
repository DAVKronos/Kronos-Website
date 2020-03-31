module Abilities
  class Everyone
    include CanCan::Ability

    def initialize(_)
      can :read, :all
      can [:home, :titleshow], Page
      can [:lustrum_signup, :lustrum_signup_new, :lustrum_enter_password], Page
	  can [:game], Page
      cannot [:read], Page
      can [:read], Page, :public => true
      can [:perdag, :month], Agendaitem
      can [:frontpage, :records], Result
      can :hide, Announcement
      can :create, [Contact]
      cannot :read, Photoalbum
      can :read, Photoalbum, :public => true
      cannot :read, [User,Photo, Announcement, Kronometer, Subscription, Comment]
      cannot :see_email, Commission
    end
  end
end
