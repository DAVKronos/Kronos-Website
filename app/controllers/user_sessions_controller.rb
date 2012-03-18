class UserSessionsController < ApplicationController
  load_and_authorize_resource
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Welkom, #{current_user.name.split[0]}."
      redirect_to nieuw_path
    else
      flash.now[:error] = "Onjuiste e-mail/wachtwoord combinatie"
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
end