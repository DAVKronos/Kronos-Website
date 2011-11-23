class UsersController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :index, :show, :edit, :update, :destroy]
  before_filter :admin_user, :only => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
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
    @users = User.all
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
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
  
  def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user) || current_user.admin?
  end
end
