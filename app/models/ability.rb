class Ability
  include CanCan::Ability

  def initialize(user)
       user ||= User.new # guest user (not logged in)
       
       can :read, :all
       can :home, Page
       can :perdag, Agendaitem
       can :frontpage, Result
       can :create, Chatmessage
       can :titleshow, Page
       can :create, User
       cannot :read, User
       cannot :read, Photoalbum
       cannot :read, Photo
       cannot :read, Kronobox
       cannot :see_email, Commission
       
       if !user.new_record?
         can :read, :all
         can :see_email, Commission
         can :archief, Agendaitem
         can :wedstrijden, Agendaitem
         can :manage, Photoalbum
         cannot :destroy, Photoalbum
         can :create, Photo
         can :create, Newsitem
         can :create, Agendaitem
         can :create, Event
         can :create, Result
         can :manage, Subscription
         can :manage, Kronobox
         cannot :destroy, Subscription
         can :destroy, user.subscriptions
         can :update, user
         can :destroy, user.chatmessages
         user.chatmessages.each do |chatmessage|
           can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
         end
         can :editpassword, user
       end
       
         
       if user.active?
         can :create, Agendaitem
         user.commissions.each do |com|
           can :update, com.agendaitems 
         end
         if user.commissions.include?(Commission.find_by_name("Redactie"))
           can :manage, Kronometer
         end
         can :read, :all
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
