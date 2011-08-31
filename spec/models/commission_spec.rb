require 'spec_helper'

describe Commission do
  let(:user){ Factory(:user) }
  let(:commis){ {:name => "test",
                 :description => "test commissie",
                 :email => "test@kronos.nl"} }
                
                it "should create an commission given valid attributes" do
                  Commission.create!(commis)
                end
                
                it "should allow to create an association" do
                  Commission.create!(commis).users << user
                end
                
                it "should save the associations" do
                  test_commission = Commission.create!(commis)
                  test_commission.users << user
                  test_commission.users.should == [user]
                end
                  
end

# == Schema Information
#
# Table name: commissions
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

