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
#  iban                   :string(255)
#  studie                 :string(255)
#  instelling             :string(255)
#  aanvang                :integer
#

require 'rails_helper'

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
	describe "attributes" do
		before { @user = FactoryGirl.build(:user) }

		  subject { @user }

		  it { is_expected.to respond_to(:name) }
		  it { is_expected.to respond_to(:initials) }
			it { is_expected.to respond_to(:email) }
			it { is_expected.to respond_to(:birthdate) }
			it { is_expected.to respond_to(:address) }
			it { is_expected.to respond_to(:postalcode) }
			it { is_expected.to respond_to(:city) }
			it { is_expected.to respond_to(:sex) }
			it { is_expected.to respond_to(:licensenumber) }
			it { is_expected.to respond_to(:papieren_kronometer) }
			it { is_expected.to respond_to(:created_at) }
			it { is_expected.to respond_to(:updated_at) }
			it { is_expected.to respond_to(:avatar_file_name) }
			it { is_expected.to respond_to(:avatar_content_type) }
			it { is_expected.to respond_to(:avatar_file_size) }
			it { is_expected.to respond_to(:avatar_updated_at) }
			it { is_expected.to respond_to(:encrypted_password) }
			it { is_expected.to respond_to(:reset_password_token) }
			it { is_expected.to respond_to(:reset_password_sent_at) }
			it { is_expected.to respond_to(:remember_created_at) }
			it { is_expected.to respond_to(:sign_in_count) }
			it { is_expected.to respond_to(:current_sign_in_at) }
			it { is_expected.to respond_to(:last_sign_in_at) }
			it { is_expected.to respond_to(:current_sign_in_ip) }
			it { is_expected.to respond_to(:last_sign_in_ip) }
			it { is_expected.to respond_to(:phonenumber) }
			it { is_expected.to respond_to(:user_type_id) }
			it { is_expected.to respond_to(:bank_account_number) }
			it { is_expected.to respond_to(:xtracard) }
	end

  it "should create a new instance given valid attributes" do
    User.create!(attr, :as => :bestuur)
  end

  it "should require a name" do
    no_name_user = User.new(attr.merge(:name => ""), :as => :bestuur)
    expect(no_name_user).not_to be_valid
  end

  it "should require initials" do
    no_initials_user = User.new(attr.merge(:initials => ""), :as => :bestuur)
    expect(no_initials_user).not_to be_valid
  end

  it "should require an address" do
    no_address_user = User.new(attr.merge(:address => ""), :as => :bestuur)
    expect(no_address_user).not_to be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(attr.merge(:email => ""), :as => :bestuur)
    expect(no_email_user).not_to be_valid
  end

  it "should require a birthdate" do
    no_birthdate_user = User.new(attr.merge(:birthdate => ""), :as => :bestuur)
    expect(no_birthdate_user).not_to be_valid
  end

  it "should require a postalcode" do
    no_postalcode_user = User.new(attr.merge(:postalcode => ""), :as => :bestuur)
    expect(no_postalcode_user).not_to be_valid
  end

  it "should require a city" do
    no_city_user = User.new(attr.merge(:city => ""), :as => :bestuur)
    expect(no_city_user).not_to be_valid
  end

  it "should require a password" do
    no_password_user = User.new(attr.merge(:password => ""), :as => :bestuur)
    expect(no_password_user).not_to be_valid
  end

  it "should require a password confirmation" do
    no_passwordcon_user = User.new(attr.merge(:password_confirmation => ""), :as => :bestuur)
    expect(no_passwordcon_user).not_to be_valid
  end

  it "should accept valid names" do
    names = ["Kegel Kronos", "Wouter Timmermans",
             "Leipe Harry", "Henk de Vries",
             "Henk de Vries-Timmermans", "Jan Peter Balkenende",
             "Willem-Frits van Oranje-Nassau"]
    names.each do |name|
      valid_name_user = User.new(attr.merge(:name => name), :as => :bestuur)
      expect(valid_name_user).to be_valid
    end
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(attr.merge(:email => address), :as => :bestuur)
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(attr.merge(:email => address), :as => :bestuur)
      expect(invalid_email_user).not_to be_valid
    end
  end

  # describe "mailinglists" do

  #   before(:each) { 
  #     @user = FactoryGirl.build(:user)  
  #     gapps = KronosGoogleAPIClient.new 
  #   }

  #   it "should add a new user to the alleleden maillist" do
  #     gapps.any_instance.should_receive(:add_group_member).with("alleleden", @user.email, @user.last_name, @user.first_name)
  #     @user.save!
  #   end

  #   it "should delete an destroyed user from the alleleden maillist" do
  #     @user.save!
  #     gapps.any_instance.should_receive(:destroy_group_member).with("alleleden", @user.email)
  #     @user.destroy
  #   end

  #   it "should update the email in the maillinglist" do
  #   end

  # end

  describe "commission associations" do

	  before(:each) do
	    @commis = FactoryGirl.create(:commission)
	    @user = User.new(attr, :as => :bestuur)
	    @user2 = FactoryGirl.create(:user)
	  end


    before do
       @user2.commission_memberships.build(:commission => @commis,:function => "Voorzitter").save!
    end


    it "should have a commission attribute" do
      expect(@user).to respond_to(:commissions)
    end

    it "should return the associated commissions" do
      expect(@user2.commissions.to_a).to eq([@commis])
    end

    it "should work the other way around too" do
      expect(@commis.users.to_a).to eq([@user2])
    end

  end
end
