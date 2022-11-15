class ReactController < Admin::ApplicationController
  skip_authorization_check
  
  def index
    render :layout => 'react'
  end
end