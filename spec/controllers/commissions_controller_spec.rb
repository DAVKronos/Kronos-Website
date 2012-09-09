require 'spec_helper'

describe CommissionsController do
  render_views
	
	describe 'guest user' do
		
		describe "GET 'new'" do
			it "should redirect to homepage" do
				get 'new'
				response.should redirect_to(root_path)
			end
		end
	end
	
	describe 'normal user' do
		login_user

	  describe "GET 'new'" do
	    it "should redirect to homepage" do
	      get 'new'
	     	response.should redirect_to(root_path)
	    end
	  end
	end
	
	describe 'admin user' do
		login_admin
		
		describe "GET 'new'" do
			it "should be succesful" do
				get 'new'
				response.should be_success
			end
		end
	end


end
