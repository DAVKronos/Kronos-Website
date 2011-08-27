class Commission < ActiveRecord::Base
  has_many :commission_memberships
  has_many :users, :through => :commission_memberships
end
