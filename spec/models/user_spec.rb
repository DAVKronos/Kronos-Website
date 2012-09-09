# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  initials               :string(255)
#  email                  :string(255)      default(""), not null
#  birthdate              :date
#  address                :string(255)
#  postalcode             :string(255)
#  city                   :string(255)
#  sex                    :string(255)
#  licensenumber          :string(255)
#  papieren_kronometer    :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  phonenumber            :string(255)
#  user_type_id           :integer
#  bank_account_number    :string(255)
#  xtracard               :string(255)
#

require 'spec_helper'

describe User do
  
  let(:attr) {   {:name => "Kegel Kronos", 
                  :initials => "H.J.K.",
                  :email => "kegel@kronos.nl", 
                  :birthdate => "01-01-2002",
                  :address => "Campuslaan 1",
                  :postalcode => "1337 MF",
                  :city => "Enschede",
                  :sex => "Man",
                  :licensenumber => "123456",
                  :password => "Foobar",
                  :password_confirmation => "Foobar"}
            }


  it "should create a new instance given valid attributes" do
    User.create!(attr, :as => :bestuur)
  end

  it "should require a name" do
    no_name_user = User.new(attr.merge(:name => ""), :as => :bestuur)
    no_name_user.should_not be_valid
  end
  
  it "should require initials" do
    no_initials_user = User.new(attr.merge(:initials => ""), :as => :bestuur)
    no_initials_user.should_not be_valid
  end
  
  it "should require an address" do
    no_address_user = User.new(attr.merge(:address => ""), :as => :bestuur)
    no_address_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(attr.merge(:email => ""), :as => :bestuur)
    no_email_user.should_not be_valid
  end
  
  it "should require a birthdate" do
    no_birthdate_user = User.new(attr.merge(:birthdate => ""), :as => :bestuur)
    no_birthdate_user.should_not be_valid
  end
  
  it "should require a postalcode" do
    no_postalcode_user = User.new(attr.merge(:postalcode => ""), :as => :bestuur)
    no_postalcode_user.should_not be_valid
  end
  
  it "should require a city" do
    no_city_user = User.new(attr.merge(:city => ""), :as => :bestuur)
    no_city_user.should_not be_valid
  end
  
  it "should require a password" do
    no_password_user = User.new(attr.merge(:password => ""), :as => :bestuur)
    no_password_user.should_not be_valid
  end
  
  it "should require a password confirmation" do
    no_passwordcon_user = User.new(attr.merge(:password_confirmation => ""), :as => :bestuur)
    no_passwordcon_user.should_not be_valid
  end
  
  it "should accept valid names" do
    names = ["Kegel Kronos", "Wouter Timmermans", "Leipe Harry", "Henk de Vries", "Henk de Vries-Timmermans"]
    names.each do |name|
      valid_name_user = User.new(attr.merge(:name => name), :as => :bestuur)
      valid_name_user.should be_valid
    end
  end
  
  it "should reject invalid names" do
    names = ["Henk de Vries-timmermans"]
    names.each do |name|
      invalid_name_user = User.new(attr.merge(:name => name), :as => :bestuur)
      invalid_name_user.should_not be_valid
    end
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(attr.merge(:email => address), :as => :bestuur)
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(attr.merge(:email => address), :as => :bestuur)
      invalid_email_user.should_not be_valid
    end
  end
  
  describe "commission associations" do
    let(:commis){ FactoryGirl.create(:commission) }
    let(:user){User.new(attr, :as => :bestuur)}
    let(:user2){ FactoryGirl.create(:user) }
    
    before do
       user2.commission_memberships.build(:commission => commis,:function => "Voorzitter").save!
    end
      
    
    it "should have a commission attribute" do
      user.should respond_to(:commissions)
    end
    
    it "should return the associated commissions" do
      user2.commissions.should == [commis]
    end
    
    it "should work the other way around too" do
      commis.users.should == [user2]
    end
    
  end
end


