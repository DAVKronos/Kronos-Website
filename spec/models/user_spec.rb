require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Kegel Kronos", 
              :initials => "H.J.K.",
              :email => "kegel@kronos.nl", 
              :birthdate => "01-01-2002",
              :address => "Campuslaan 1",
              :postalcode => "1337 MF",
              :city => "Enschede",
              :sex => "Man",
              :licensenumber => "123456" }
  end


  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require initials" do
    no_initials_user = User.new(@attr.merge(:initials => ""))
    no_initials_user.should_not be_valid
  end
  
  it "should require an address" do
    no_address_user = User.new(@attr.merge(:address => ""))
    no_address_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should require an birthdate" do
    no_birthdate_user = User.new(@attr.merge(:birthdate => ""))
    no_birthdate_user.should_not be_valid
  end
  
  it "should require an postalcode" do
    no_postalcode_user = User.new(@attr.merge(:postalcode => ""))
    no_postalcode_user.should_not be_valid
  end
  
  it "should require a city" do
    no_city_user = User.new(@attr.merge(:city => ""))
    no_city_user.should_not be_valid
  end
end