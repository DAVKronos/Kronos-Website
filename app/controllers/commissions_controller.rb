require File.join(Rails.root, 'lib','gapps')
class CommissionsController < ApplicationController
  
  access_control do
    actions :destroy, :new, :create, :update, :edit do
      allow :admin
    end
    actions :index, :show do
      allow all
    end
  end
  
  def new
    @commission = Commission.new
  end
  
  def create
    @commission = Commission.new(params[:commission])
    gapps = Gapps.new
    gapps.create_group(@commission.email.split('@').first, @commission.name, @commission.description)
    if @commission.save
      redirect_to @commission
    else
      render 'new'
    end
  end
  
  def show
    @commission = Commission.find_by_id(params[:id])
    @commission_memberships = Commission.find_by_id(params[:id]).commission_memberships
  end
  
  def index
    @commissions = Commission.all
  end
  
  def edit
    @commission = Commission.find_by_id(params[:id])
    @commission_membership = CommissionMembership.new
    @commission_membership.commission_id = @commission.id
    @commission_memberships = @commission.commission_memberships
  end
  
  def update
    @commission = Commission.find_by_id(params[:id])
    if @commission.update_attributes(params[:commission])
      flash[:success] = "Commission updated."
      redirect_to @commission
    else
      render 'edit'
    end
  end
  
  def destroy
     commission = Commission.find(params[:id])
     gapps = Gapps.new
     gapps.destroy_group(commission.email.split('@').first)
      commission.destroy
      flash[:success] = "Commissie Verwijderd"
      redirect_to commissions_path
  end
end