require 'spec_helper'

describe UserSessionsController do
  render_views
  
  describe "POST 'create'" do
    before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.login, :password => @user.password }
      end
      
    it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
  
  describe "DELETE 'destroy'" do

    it "should sign a user out" do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

end
