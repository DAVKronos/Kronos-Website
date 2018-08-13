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
#  role        :string(255)
#

require 'rails_helper'

describe Commission do
  let(:user){ FactoryGirl.create(:user) }
  let(:commis){ {:name => "test",
                 :description => "test commissie",
                 :email => "test@kronos.nl"} }
                
                it "should create an commission given valid attributes" do
                  Commission.create!(commis)
                end
                
                it "should allow to create an association" do
                  user.commission_memberships.build(:commission => Commission.create!(commis),:function => "Voorzitter").save!
                end
                
                it "should save the associations" do
                  test_commission = Commission.create!(commis)
                  user.commission_memberships.build(:commission => test_commission,:function => "Voorzitter").save!
                  expect(test_commission.users).to eq([user])
                end
                  
end
