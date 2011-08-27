class CommissionMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :commission
end
