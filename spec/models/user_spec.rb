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
              :licensenumber => "123456",
              :login => "Henk",
              :password => "Foobar",
              :password_confirmation => "Foobar"}
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
  
  it "should accept valid names" do
    names = ["Kegel Kronos", "Wouter Timmermans", "Leipe Harry", "Henk de Vries", "Henk de Vries-Timmermans"]
    names.each do |name|
      valid_name_user = User.new(@attr.merge(:name => name))
      valid_name_user.should be_valid
    end
  end
  
  it "should reject invalid names" do
    names = ["Kegel", "Wouter", "Leipe", "Vries", "Henk De Vries", "Henk de Vries-timmermans"]
    names.each do |name|
      invalid_name_user = User.new(@attr.merge(:name => name))
      invalid_name_user.should_not be_valid
    end
  end
  
  it "should accept valid initials" do
    initials = %w[H.D.V. W.J.M. W. S.B.P.E. H.K.]
    initials.each do |initials|
      valid_initials_user = User.new(@attr.merge(:initials => initials))
      valid_initials_user.should be_valid
    end
  end
  
  it "should reject invalid initials" do
    initials = ["h.d.v.", "wjm", "WJM", "S B P E", "H K"]
    initials.each do |initials|
      invalid_initials_user = User.new(@attr.merge(:initials => initials))
      invalid_initials_user.should_not be_valid
      end
    end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
end
      
