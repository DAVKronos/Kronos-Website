class Ability
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user (not logged in)
       if user.admin?
         can :manage, :all
         cannot :update, Chatmessage
         user.chatmessages.each do |chatmessage|
           can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
         end
         can :titleshow, Page
         can :update_mailinglists, User
       elsif user.active?
         can :create, Agendaitem
         can :update, user.commissions.each do |com|
           com.agendaitems 
         end
         if user.commissions.include?(Commission.find_by_name("Redactie"))
           can :manage, Kronometer
         end
         can :read, :all
         can :home, Page
         can :frontpage, Result
         can :archief, Agendaitem
         can :wedstrijden, Agendaitem
         can :manage, Photoalbum
         cannot :destroy, Photoalbum
         can :create, Photo
         can :create, Newsitem
         can :manage, Subscription
         cannot :destroy, Subscription
         can :destroy, user.subscriptions
         can :update, user
         can :create, Chatmessage
         can :destroy, user.chatmessages
         user.chatmessages.each do |chatmessage|
           can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
         end
         can :titleshow, Page
       elsif !user.new_record?
         can :read, :all
         can :home, Page
         can :frontpage, Result
         can :archief, Agendaitem
         can :wedstrijden, Agendaitem
         can :manage, Photoalbum
         cannot :destroy, Photoalbum
         can :create, Photo
         can :create, Newsitem
         can :manage, Subscription
         cannot :destroy, Subscription
         can :destroy, user.subscriptions
         can :update, user
         can :create, Chatmessage
         can :destroy, user.chatmessages
         user.chatmessages.each do |chatmessage|
           can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
         end
         can :titleshow, Page
       else
         can :read, :all
         can :home, Page
         can :frontpage, Result
         can :create, Chatmessage
         can :titleshow, Page
         cannot :read, User
         cannot :read, Photoalbum
         cannot :read, Photo
       end
  end
end
