require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :email => "", :address => "",
                  :initials => "", :birthdate => "",
                  :city => "", :postalcode => "",
                  :licensenumber => "", :sex => "",
                  :login => "", :password => "",
                  :password_confirmation => ""}
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = { :name => "Henk de Vries", :email => "h.devries@gmail.com", 
                  :address => "Straatzondernaam 3",
                  :initials => "H.D.V.",
                  :birthdate => "16-06-1991",
                  :city => "Jeruzalem",
                  :postalcode => "0000 BC",
                  :licensenumber => "000000",
                  :sex => "Man",
                  :login => "Henk",
                  :password => "Foobar",
                  :password_confirmation => "Foobar"}
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end    
    end
  end
end
