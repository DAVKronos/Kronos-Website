module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      load_and_authorize_resource
      skip_load_resource only: :create

      def create
        user = User.new(user_params)
        password = Devise.friendly_token.first(10)
        user.password = password
        user.password_confirmation = password
        user.user_type = UserType.find_by_name('Proeflid') unless current_user
        if user.save
          UserMailer.welcome_email(user, password).deliver
          render json: user.as_json(include: {commissions: {only: [:name, :name_en]}}, methods: [:avatar_url_medium, :avatar_url_thumb])
        else
          render json: {message: user.errors.full_messages}, status: :bad_request
        end
      end

      def show
        user = User.find_by_id(params[:id])
        respond_to do |format|
          format.json { render json: user.as_json(include: {commissions: {only: [:name, :name_en]}}, methods: [:avatar_url_medium, :avatar_url_thumb]) }
        end
      end

      def index
        user_type_id = params[:user_type_id].to_f if params[:user_type_id].present?

        @users = current_user.allowed_users(user_type_id).order(:name)

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
          format.json { render json: @users.map { |user| user.as_json(methods: [:avatar_url_medium, :avatar_url_thumb, :avatar_url_pass]) } }
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

      def update
        user = User.find_by_id(params[:id])
        if user.update(user_params)
          render json: user.as_json(include: {commissions: {only: [:name, :name_en]}}, methods: [:avatar_url_medium, :avatar_url_thumb])
        else
          render json: {message: user.errors.full_messages}, status: :bad_request
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: user
        else
          render json: {message: user.errors.full_messages}, status: :bad_request
        end
      end

      def xtracard
        @users = User.where(user_type_id: [1, 2])
      end

      def birthdays
        birthdays = {}
        birthdays['current_month'] = User.where('(user_type_id not in (?)) AND
                               (extract(month from birthdate) = ? AND extract(day from birthdate) >= ?)
                              ',
                                                 [9],
                                                 Date.today.strftime("%m"), Date.today.strftime("%d"))
                                          .order(Arel.sql('extract(month from birthdate) ASC, extract(day from birthdate) ASC'))

        birthdays['next_month'] = User.where('(user_type_id not in (?)) AND
                               (extract(month from birthdate) = ? AND extract(day from birthdate) <= ?)
                              ',
                                              [9],
                                              Date.today.next_month.strftime("%m"), Date.today.next_month.strftime("%d"))
                                       .order(Arel.sql('extract(month from birthdate) ASC, extract(day from birthdate) ASC'))
        @all_birthdays = birthdays['current_month'] + birthdays['next_month']
        respond_to do |format|
          format.html
          format.json {render json: @all_birthdays.map{|user| user.as_json(methods: [:avatar_url_thumb])}}
        end
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
  end
end
