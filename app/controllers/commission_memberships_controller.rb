class CommissionMembershipsController < ApplicationController
  def new
    @commission_membership = CommissionMembership.new
  end

  def create
    @commission_membership = CommissionMembership.new(params[:commission_membership])
    if @commission_membership.save
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
  end

end
