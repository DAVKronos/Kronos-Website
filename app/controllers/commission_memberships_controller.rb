class CommissionMembershipsController < Admin::ApplicationController
  load_and_authorize_resource
  
  def destroy
    commission_membership = CommissionMembership.find(params[:id])
    commission_membership.destroy
        flash[:success] = "#{commission_membership.user.name} Verwijderd"
        redirect_to edit_commission_path(commission_membership.commission)
  end

end
