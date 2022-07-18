class CommissionMembershipsController < Admin::ApplicationController
  load_and_authorize_resource
  
  def index
    memberships = CommissionMembership.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: memberships}
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
      params.require(:commission_membership).permit(:user_id, :function)
    end
  end

end
