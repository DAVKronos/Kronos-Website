class CommissionsController < ApplicationController
  
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
    @users = Commission.find_by_id(params[:id]).users
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
  
  def delete
  end
  
  
end