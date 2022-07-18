module Api
  module V1
    class CommissionMembershipsController <Api::V1::ApplicationController
      load_and_authorize_resource
      
      def index
        memberships = CommissionMembership.where(commission_id: params[:commission_id])
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: memberships.as_json(include: {user: {only: :name}})}
        end
      end
    
      def create
        commission_membership = CommissionMembership.new(commission_membership_params)
        if commission_membership.save
          render json: commission_membership
        else
          render json: {message: commission_membership.errors.full_messages}, status: :bad_request
        end
      end
    
      def update
        commission_membership = CommissionMembership.find(params[:id])
        if commission_membership.update_attributes(commission_membership_params)
          render json: commission_membership
        else
          render json: {message: commission_membership.errors.full_messages}, status: :bad_request
        end
      end
    
      def destroy
        commission_membership = CommissionMembership.find(params[:id])
        commission_membership.destroy
        if commission_membership.destroy
          respond_to do |format|
            format.json { head :ok }
          end
        else
          render json: {message: commission_membership.errors.full_messages}, status: :bad_request
        end
      end
    
      private
        def commission_membership_params
          params.require(:commission_membership).permit(:commission_id, :user_id, :function)
        end
      
    
    end
    
  end
end
