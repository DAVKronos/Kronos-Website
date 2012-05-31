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
         can :update, user
         can :create, Chatmessage
         can :destroy, user.chatmessages
         user.chatmessages.each do |chatmessage|
           can :update, chatmessage if chatmessage.created_at > 5.minutes.ago
         end
       else
         can :read, :all
         can :home, Page
         can :create, Chatmessage
         cannot :read, User
         cannot :read, Photoalbum
         cannot :read, Photo
       end
  end
end
