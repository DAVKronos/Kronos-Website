module Abilities
  class Everyone
    include CanCan::Ability

    def initialize(_)
      can :read, :all
      can [:home, :titleshow], Page
	    can [:game], Page
      cannot [:read], Page
      can [:read], Page, :public => true
      can [:perdag, :month], Agendaitem
      can [:frontpage, :records], Result
      can [:current, :hide], Announcement
      can :create, [Contact]
      cannot :read, Photoalbum
      can :read, Photoalbum, :public => true
      cannot :read, [User, Photo, Announcement, Kronometer, Subscription, Comment]
      # can :read, Photo, photoalbum: { public: true } see https://github.com/CanCanCommunity/cancancan/issues/661
      can [:read, :display], Kronometer, :public => true
      cannot :see_email, Commission
    end
  end
end
