class Agendaitem < ActiveRecord::Base
  belongs_to :commission
  has_one :photoalbum
  has_many :events
  has_many :subscriptions
  has_many :reactions
  accepts_nested_attributes_for :events, :allow_destroy => true, :reject_if => proc { |attributes| attributes['eventtype_id'] == "" }
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  
  def allow_edit?(user)
    if user
      user.commissions.each do |commission|
        if (commission.id == self.commission_id)
          return true
        end
      end
    else
      return false
    end
  end
  
  def allow_destroy?(user)
    if user
      user.commissions.each do |commission|
        if (commission.id == self.commission_id)
          return true
        end
      end
    else
      return false
    end
  end
end
