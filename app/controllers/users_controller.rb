class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => :create
  
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user], :as => :bestuur)
    password = Devise.friendly_token.first(10)
    user.password = password
    user.password_confirmation = password
		if !current_user
			user.user_type = UserType.find_by_name("Proeflid")
		end
    if user.save
      UserMailer.welcome_email(user,password).deliver
			if !current_user
				sign_in user, :bypass => true
			end
      redirect_to user
    else
	  @user = user
      render 'new'
    end
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def index
    if current_user && current_user.admin?
      @users, @alphaParams = User.where('user_type_id not in (?)', [9]).order('name asc').alpha_paginate(params[:letter],{:include_all=>false,:js=>false,:bootstrap3=>true}){|user| user.name}
    else
      @users, @alphaParams = User.where(:user_type_id => [1,2,8]).order('name asc').alpha_paginate(params[:letter], {:include_all=>false,:js=>false,:bootstrap3=>true}){|user| user.name}
    end
    respond_to do |format|
          format.html
          format.pdf do
            @users = Array.new
            counter = 0
            UserType.all.each do |ut|
              @users[counter] = Array.new
              ut.users.each do |user|
                @users[counter] << user
              end
              counter += 1
            end
            render :pdf => "ledenlijst #{Time.now}"
          end
        end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    user = User.find_by_id(params[:id])
        role = (current_user.admin? ? :bestuur : :default)
        if user.update_attributes(params[:user], :as => role)
          flash[:success] = "Profile updated."
          sign_in user, :bypass => true unless current_user.admin?
          redirect_to user
        else
          render 'edit'
        end
      end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "Gebruiker verwijderd"
      redirect_to users_path
  end
  
  def update_mailinglists
    User.all.each do |user|
      user.add_member_to_group
    end
    redirect_to :root
    flash[:success] = "Ik ben de mailinglijst aan het herbouwen, een ogenblik"
  end
  
  def xtracard
    @users = User.where(:user_type_id => [1,2])
  end

  private
    def user_current_user?
      @user = User.find(params[:id])
      current_user?(@user)
    end
end