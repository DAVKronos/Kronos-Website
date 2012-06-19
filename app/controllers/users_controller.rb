class UsersController < ApplicationController
  load_and_authorize_resource
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user], :as => :bestuur)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def index
    @users = User.where(:user_type_id => 1||2).order('name asc').paginate(:page => params[:page], :per_page => 12)
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    user = User.find_by_id(params[:id])
        role = (current_user.admin? ? :bestuur : :default)
        if user.update_attributes(params[:user], :as => role)
          flash[:success] = "Profile updated."
          sign_in user, :bypass => true
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

  private
    def user_current_user?
      @user = User.find(params[:id])
      current_user?(@user)
    end
end