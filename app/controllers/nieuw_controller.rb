class NieuwController < ApplicationController
  
  def index
    if(current_user)
      @users = User.where(:created_at => (current_user.last_login_at)..(Time.now)).paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 10)
      @chatmessages = Chatmessage.where(:created_at => (current_user.last_login_at)..(Time.now)).paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 10)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chatmessages }
    end
  end
  
end
