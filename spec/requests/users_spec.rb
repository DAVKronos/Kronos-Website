require 'spec_helper'

describe "The login form" do
	before(:each) do
		@password = Devise.friendly_token.first(10)
		@user = FactoryGirl.create(:user, password: @password, password_confirmation: @password)
		login_user
	end
	
	def login_user
    visit root_path 
    fill_in "user_email", :with => @user.email
		fill_in "user_password", :with => @password
    click_button "Inloggen"
	end
	
	it "logins the user" do
   	page.should have_content(@user.name.split[0] + "'s stek")  
  end

	describe "The stek" do
		it "show's the profile page" do
			click_link @user.name.split[0] + "'s stek"
			page.should have_content(@user.name)
		end
		
		it "allows the user to update information" do
			click_link @user.name.split[0] + "'s stek"
			click_link "pas je gegevens aan"
			page.should have_content "Aanpassen"
		end
	end
end
