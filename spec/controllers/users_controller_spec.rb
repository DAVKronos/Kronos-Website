require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
	
	describe "Create trial member" do
		it "should be successful" do
			user = FactoryGirl.create(:user)
		end
	end
end