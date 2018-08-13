# == Schema Information
#
# Table name: commission_memberships
#
#  id            :integer          not null, primary key
#  function      :string(255)
#  installed     :boolean          default(FALSE)
#  user_id       :integer          not null
#  commission_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

describe CommissionMembership do
  let(:user){ FactoryGirl.create(:user) }
  let(:commis){ FactoryGirl.create(:commission) }
  let(:membership){ user.commission_memberships.build(:commission => commis,:function => "Voorzitter")}
  
  it "should create a new instance given valid attributes" do
      membership.save!
  end
  
end
