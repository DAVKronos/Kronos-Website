class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

# iedereen
    can :read, :all
    can :home, Page
    can :perdag, Agendaitem
    can :month, Agendaitem
    can :frontpage, Result
    can :create, Chatmessage
    can :titleshow, Page
    can :hide_banner, Page
    cannot :read, User
    cannot :read, Photoalbum
    cannot :read, Photo
    cannot :see_email, Commission

# geen member
	if user.new_record?
      can :create, User
    end

# oud-leden mogen niets meer
    return if user.oudlid?

# leden
    if !user.new_record?
      can :read, :all
      can :see_email, Commission
      can :archief, Agendaitem
      can :wedstrijden, Agendaitem
      can :manage, Photoalbum
      cannot :destroy, Photoalbum
      can :create, Photo
      can :create, Newsitem
      can :new_result, Agendaitem
      can :create_result, Agendaitem
      can :create, Agendaitem
      can :update, user.agendaitems
      can :create, Event
      can :create, Result
      can :manage, Subscription
      cannot :destroy, Subscription
      can :destroy, user.subscriptions
      can :update, user
      can :destroy, user.chatmessages
      user.chatmessages.each do |chatmessage|
        can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
      end
      can :editpassword, user
    end
       
# actieve leden
    if user.active?
      can :manage, user.agendaitems
      user.commissions.each do |com|
        can :update, com.agendaitems
      end
      can :read, :all
    end

# rollen
    if user.kronometer_admin?
      can :manage, Kronometer
    end
    if user.uitslagen_admin?
      can :manage, Result
    end
    if user.admin?
      can :manage, :all
      cannot :update, Chatmessage
      user.chatmessages.each do |chatmessage|
        can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
      end
      can :update_mailinglists, User
    end
  end
end
