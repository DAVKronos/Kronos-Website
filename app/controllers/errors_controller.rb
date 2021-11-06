class ErrorsController < Admin::ApplicationController
  load_and_authorize_resource
  def routing
     render '404', :status => 404, :layout => 'application'
  end
end

