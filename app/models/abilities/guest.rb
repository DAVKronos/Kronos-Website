module Abilities
  class Guest
    include CanCan::Ability

    def initialize(user)
      #no defined abilities
    end
  end
end
