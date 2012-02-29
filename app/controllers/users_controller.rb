class UsersController < ApplicationController
  access_control do
        actions :new, :create, :destroy do
          allow :admin
        end
        actions :index, :show do
          allow logged_in
        end
        actions :edit, :update do
          allow logged_in, :if => :user_current_user?
          allow :admin
        end
    end
  
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
    @users = User.paginate(:page => params[:page])
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    user = User.find_by_id(params[:id])
        role = (current_user.has_role?(:admin) ? :bestuur : :default)
        if user.update_attributes(params[:user], :as => role)
          flash[:success] = "Profile updated."
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