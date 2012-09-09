require 'spec_helper'

describe CommissionsController do
  render_views

  describe "GET 'new'" do
    it "should be unsuccessful" do
      get 'new'
      response.should be_redirect
    end
  end


end
