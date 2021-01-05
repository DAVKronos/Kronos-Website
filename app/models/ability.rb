class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    merge Abilities::Everyone.new(user)

    if !user.new_record?
      merge Abilities::Authenticated.new(user)
      merge Abilities::Admin.new(user) if user.admin?
    else
      merge Abilities::Guest.new(user)
    end
  end

  def to_list
    rules.map do |rule|
      object = { action: rule.actions, subject: rule.subjects.map{ |s| s.is_a?(Symbol) ? s : s.name } }
      object[:conditions] = rule.conditions unless rule.conditions.blank?
      object[:inverted] = true unless rule.base_behavior
      object
    end
  end
end
