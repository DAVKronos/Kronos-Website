class CommissionMembershipsController < ApplicationController
  def new
    @commission_membership = CommissionMembership.new
  end

  def create
    @commission_membership = CommissionMembership.new(params[:commission_membership])
    if @commission_membership.save
      gapps = Gapps.new
      gapps.add_group_member(@commission_membership.commission.email.split("@").first, @commission_membership.user.email)
      redirect_to @commission_membership
    else
      render 'new'
    end
  end

  def show
    @commission_membership = CommissionMembership.find_by_id(params[:id])
  end

  def update
  end

  def delete
    commission_membership = Commission.find(params[:id])
     gapps = Gapps.new
     gapps.destroy_group_member(commission_membership.commission.email.split("@").first, commission_membership.user.email)
      commission_membership.destroy
      flash[:success] = "#{commission_membership.user.name} Verwijderd"
      redirect_to commissions_path
  end

end
