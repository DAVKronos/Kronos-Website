module Api
  module V1
    class MailinglistsController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        @mailinglists = Mailinglist.all
        render json: @mailinglists
      end

      def show
        @mailinglist = Mailinglist.find(params[:id])
        render json: @mailinglist.to_json(:include => {:aliases => {:only => :id}, :users => {:only => :id}, :mailinglists => {:only => :id}})
      end

      def edit
        @mailinglist = Mailinglist.find(params[:id])
        @users = @mailinglist.get_possible_users
        @aliases = Alias.order(:name)
        @mailinglists = Mailinglist.all
      end

      def create
        mailinglist = Mailinglist.new(mailinglist_params)
        if mailinglist.save
           render json: mailinglist.to_json(:include => {:aliases => {:only => :id}, :users => {:only => :id}, :mailinglists => {:only => :id}})
        else
          ender json: {message: @mailinglist.errors.full_messages}, status: :bad_request
        end
      end

      def destroy
        mailinglist = Mailinglist.find(params[:id])
        if mailinglist.destroy
          respond_to do |format|
            format.json { head :ok }
          end
        else
          render json: {message: mailinglist.errors.full_messages}, status: :bad_request
        end
      end

      def update
        @mailinglist = Mailinglist.find(params[:id])
        if @mailinglist.update_attributes(mailinglist_params)
          render json: @mailinglist.to_json(:include => {:aliases => {:only => :id}, :users => {:only => :id}, :mailinglists => {:only => :id}})
        else
          render json: {message: @mailinglist.errors.full_messages}, status: :bad_request
        end
      end

      private

      def mailinglist_params
        params.require(:mailinglist).permit(:description, :name, :local_part, :mailinglist_memberships_attributes, :commission_id, user_ids: [], alias_ids: [],)
      end
    end
  end
end

