class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :create

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
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
    @commissions = @user.commissions.order("name").all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json:  @user.as_json(methods: [:avatar_url_normal, :avatar_url_thumb])}
    end
  end

  def index
    user_type_id = params[:user_type_id].to_f if params[:user_type_id].present?

    @users = current_user.allowed_users(user_type_id)

    respond_to do |format|
      format.html do
        @users, @alpha_params = @users.alpha_paginate(
            params[:letter],
            include_all: false,
            js: true,
            bootstrap3: true) { |user| user.name }
        @usertypes = current_user.allowed_user_types
      end
      format.pdf do
        render pdf: "ledenlijst #{Time.now}"
      end
    end
  end

  def kronometer_list
    user_type_id = params[:user_type_id].to_f if params[:user_type_id].present?
    @users = current_user.allowed_users(user_type_id)

    respond_to do |format|
      format.pdf do
        render pdf: "kronometerlijst #{Time.now}"
      end
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    user = User.find_by_id(params[:id])
    if user.update_attributes(user_params)
      flash[:success] = 'Profile updated.'
      sign_in user, bypass: true unless current_user.admin?
      redirect_to user
    else
      flash[:danger] = 'Update failed.'
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

  def user_params
    permitted_params = [:email, :address, :postalcode, :studie, :aanvang,
                        :instelling, :city, :phonenumber, :password,
                        :password_confirmation, :papieren_kronometer, :avatar,
                        :avatar_file_name, :remember_me]

    if current_user.admin?
      permitted_params.concat([:name, :initials, :birthdate,
                               :sex, :licensenumber, :user_type_id,
                               :xtracard, :bank_account_number, :iban])
    end
    params.require(:user).permit(permitted_params)


  end
end
