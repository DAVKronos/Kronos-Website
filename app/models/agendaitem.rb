class Agendaitem < ActiveRecord::Base
  belongs_to :commission
  has_many :photoalbums
  has_many :events, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :reactions, :dependent => :destroy
  belongs_to :agendaitemtype
  accepts_nested_attributes_for :events, :allow_destroy => true
  accepts_nested_attributes_for :subscriptions, :allow_destroy => true
  validates_associated :events
  
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
  
  def count_results()
    counter = 0
    self.events.each do |ev|
      counter += ev.results.count
    end
    return counter
  end
end
# == Schema Information
#
# Table name: agendaitems
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  description          :text
#  date                 :date
#  location             :string(255)
#  subscribe            :boolean
#  subscriptiondeadline :datetime
#  commission_id        :integer
#  created_at           :datetime
#  updated_at           :datetime
#  category             :string(255)
#  intern               :boolean
#  agendaitemtype_id    :integer
#

