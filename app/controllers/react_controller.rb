class ReactController < Admin::ApplicationController
  load_and_authorize_resource

  def index
    render :layout => 'react'
  end
end