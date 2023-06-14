module Api
  module V1
    class CommissionsController < Api::V1::ApplicationController
      load_and_authorize_resource

      def create
        commission = Commission.new(commission_params)
        if commission.save
          render json: commission
        else
          render json: {message: commission.errors.full_messages}, status: :bad_request
        end
      end

      def show
        @commission = Commission.find_by_id(params[:id])

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @commission }
        end
      end

      def index
        @commissions = Commission.order("name").all
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @commissions }
        end
      end

      def update
        commission = Commission.find_by_id(params[:id])
        if commission.update(commission_params)
          render json: commission
        else
          render json: {message: commission.errors.full_messages}, status: :bad_request
        end
      end

      def destroy
        commission = Commission.find(params[:id])
        commission.destroy
        if commission.destroy
          respond_to do |format|
            format.json { head :ok }
          end
        else
          render json: {message: commission.errors.full_messages}, status: :bad_request
        end
      end

      private

      def commission_params
        # TODO controller now permits all models attributes, try to be more specific
        params.require(:commission).permit!
      end
    end
  end
end
