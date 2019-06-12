module Abilities
  class Everyone
    include CanCan::Ability

    def initialize(_)
      can :read, :all
      can [:home, :titleshow], Page
      cannot [:read], Page
      can [:read], Page, :public => true
      can [:perdag, :month], Agendaitem
      can [:frontpage, :records], Result
      can :hide, Announcement
      can :create, [Contact]
      cannot :read, Photoalbum
      can :read, Photoalbum, :public => true
      cannot :read, [User,Photo, Announcement, Kronometer, Subscription]
      cannot :see_email, Commission
    end
  end
end
