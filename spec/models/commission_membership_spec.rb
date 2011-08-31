require 'spec_helper'

describe CommissionMembership do
  let(:user){ Factory(:user) }
  let(:commis){ Factory(:commission) }
  let(:membership){ user.commission_memberships.build(:commission => commis)}
  
  it "should create a new instance given valid attributes" do
      membership.save!
    end
  
end

# == Schema Information
#
# Table name: commission_memberships
#
#  id            :integer         not null, primary key
#  function      :string(255)
#  installed     :boolean
#  user_id       :integer
#  commission_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

