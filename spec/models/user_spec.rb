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
                  :login => "Henk",
                  :password => "Foobar",
                  :password_confirmation => "Foobar"}
            }


  it "should create a new instance given valid attributes" do
    User.create!(attr)
  end

  it "should require a name" do
    no_name_user = User.new(attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require initials" do
    no_initials_user = User.new(attr.merge(:initials => ""))
    no_initials_user.should_not be_valid
  end
  
  it "should require an address" do
    no_address_user = User.new(attr.merge(:address => ""))
    no_address_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should require a birthdate" do
    no_birthdate_user = User.new(attr.merge(:birthdate => ""))
    no_birthdate_user.should_not be_valid
  end
  
  it "should require a postalcode" do
    no_postalcode_user = User.new(attr.merge(:postalcode => ""))
    no_postalcode_user.should_not be_valid
  end
  
  it "should require a city" do
    no_city_user = User.new(attr.merge(:city => ""))
    no_city_user.should_not be_valid
  end
  
  it "should require a login" do
    no_login_user = User.new(attr.merge(:login => ""))
    no_login_user.should_not be_valid
  end
  
  it "should require a password" do
    no_password_user = User.new(attr.merge(:password => ""))
    no_password_user.should_not be_valid
  end
  
  it "should require a password confirmation" do
    no_passwordcon_user = User.new(attr.merge(:password_confirmation => ""))
    no_passwordcon_user.should_not be_valid
  end
  
  it "should accept valid names" do
    names = ["Kegel Kronos", "Wouter Timmermans", "Leipe Harry", "Henk de Vries", "Henk de Vries-Timmermans"]
    names.each do |name|
      valid_name_user = User.new(attr.merge(:name => name))
      valid_name_user.should be_valid
    end
  end
  
  it "should reject invalid names" do
    names = ["Kegel", "Wouter", "Leipe", "Vries", "Henk De Vries", "Henk de Vries-timmermans"]
    names.each do |name|
      invalid_name_user = User.new(attr.merge(:name => name))
      invalid_name_user.should_not be_valid
    end
  end
  
  it "should accept valid initials" do
    initials = %w[H.D.V. W.J.M. W. S.B.P.E. H.K.]
    initials.each do |initials|
      valid_initials_user = User.new(attr.merge(:initials => initials))
      valid_initials_user.should be_valid
    end
  end
  
  it "should reject invalid initials" do
    initials = ["h.d.v.", "wjm", "WJM", "S B P E", "H K", "Henk K.", "Henk Karel"]
    initials.each do |initials|
      invalid_initials_user = User.new(attr.merge(:initials => initials))
      invalid_initials_user.should_not be_valid
      end
    end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  describe "commission associations" do
    let(:commis){ Factory(:commission) }
    let(:user){User.new(attr)}
    let(:user2){ Factory(:user) }
    
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



# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  initials               :string(255)
#  email                  :string(255)     default(""), not null
#  birthdate              :date
#  address                :string(255)
#  postalcode             :string(255)
#  city                   :string(255)
#  sex                    :string(255)
#  licensenumber          :string(255)
#  papieren_kronometer    :boolean         default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  phonenumber            :string(255)
#

