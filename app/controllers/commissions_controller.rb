require File.join(Rails.root, 'lib','gapps')

class CommissionsController < ApplicationController
  before_filter :authenticate, :only => [:destroy, :new, :create, :update, :edit]
  before_filter :admin_user,   :only => [:destroy, :new, :create, :update, :edit]
  
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
  
  def destroy
     commission = Commission.find(params[:id])
     gapps = Gapps.new
     gapps.destroy_group(commission.email.split('@').first)
      commission.destroy
      flash[:success] = "Commissie Verwijderd"
      redirect_to commissions_path
  end
  
  private
  
  def admin_user
      redirect_to(commissions_path) unless current_user.admin?
    end
  
  
end