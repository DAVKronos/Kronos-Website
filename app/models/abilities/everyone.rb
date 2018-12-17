module Abilities
  class Everyone
    include CanCan::Ability

    def initialize(_)
      can :read, :all
      can [:home, :titleshow], Page
      can [:perdag, :month], Agendaitem
      can [:frontpage, :records], Result
      can :hide, Announcement
      can :create, [Contact]
      cannot :read, Photoalbum
      can :read, Photoalbum, :public => true
      cannot :read, [User, Photo, Announcement, Kronometer]
      cannot :see_email, Commission
    end
  end
end
