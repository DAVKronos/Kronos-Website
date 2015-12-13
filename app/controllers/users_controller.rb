class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :create

  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user], as: :bestuur)
    password = Devise.friendly_token.first(10)
    user.password = password
    user.password_confirmation = password
    user.user_type = UserType.find_by_name('Proeflid') unless current_user
    if user.save
      UserMailer.welcome_email(user, password).deliver
      sign_in user, bypass: true unless current_user
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
    user_type_id = params[:user_type_id].to_f if params[:user_type_id].present?

    @users = current_user.allowed_users(user_type_id)

    respond_to do |format|
      format.html do
        @users, @alpha_params = @users.alpha_paginate(
          params[:letter],
          include_all: false,
	  params: {user_type_id: params[:user_type_id]},
          js: true,
          bootstrap3: true) { |user| user.name }
        @usertypes = current_user.allowed_user_types
      end
      format.pdf do
        render pdf: "ledenlijst #{Time.now}"
      end
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    user = User.find_by_id(params[:id])
    role = (current_user.admin? ? :bestuur : :default)
    if user.update_attributes(params[:user], as: role)
      flash[:success] = 'Profile updated.'
      sign_in user, bypass: true unless current_user.admin?
      redirect_to user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = 'Gebruiker verwijderd'
    redirect_to users_path
  end

  def xtracard
    @users = User.where(user_type_id: [1, 2])
  end

  private

  def user_current_user?
    @user = User.find(params[:id])
    current_user?(@user)
  end
end
