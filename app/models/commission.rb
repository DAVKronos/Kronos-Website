# == Schema Information
#
# Table name: commissions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  email       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Commission < ActiveRecord::Base
  has_many :commission_memberships, :dependent => :destroy
  has_many :users, :through => :commission_memberships
  has_many :agendaitems
  
  accepts_nested_attributes_for :commission_memberships, :allow_destroy => true
end
