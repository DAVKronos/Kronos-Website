class CommissionsController < ApplicationController
  load_and_authorize_resource
  
  def new
    @commission = Commission.new
  end
  
  def create
    @commission = Commission.new(params[:commission])
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
      commission.destroy
      flash[:success] = "Commissie Verwijderd"
      redirect_to commissions_path
  end
end