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
         can :create, Chatmessage
         can :create, Photoalbum
         can :create, Photo
         can :update, user
         can :update, Photoalbum
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
