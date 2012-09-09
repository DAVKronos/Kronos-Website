require 'spec_helper'

describe "Users" do
	describe "Filling in the login form" do
		it "logins the user" do
			user = FactoryGirl.create(:user)
	    visit root_path 
	    fill_in "user_email", :with => user.email
			fill_in "user_password", :with => "foobar"
	    click_button "Inloggen"  
	    page.should have_content(user.name.split[0] + "'s stek")  
	  end  
	end  
end
