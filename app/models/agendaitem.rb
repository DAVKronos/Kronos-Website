class Agendaitem < ActiveRecord::Base
  belongs_to :commission
  has_one :photoalbum
  has_many :events
  has_many :subscriptions, :dependent => :destroy
  has_many :reactions, :dependent => :destroy
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
end
# == Schema Information
#
# Table name: agendaitems
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  description          :text
#  date                 :datetime
#  location             :string(255)
#  subscribe            :boolean
#  subscriptiondeadline :datetime
#  commission_id        :integer
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  category             :string(255)
#  intern               :boolean
#

