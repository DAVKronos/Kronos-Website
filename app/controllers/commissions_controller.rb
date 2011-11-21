class CommissionsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :admin_user,   :only => :destroy
  
  def new
    @commission = Commission.new
  end
  
  def create
    @commission = Commission.new(params[:commission])
    gapps_login
    post = <<-EOF
<atom:entry xmlns:atom="http://www.w3.org/2005/Atom" xmlns:apps="http://schemas.google.com/apps/2006" xmlns:gd="http://schemas.google.com/g/2005">
      <apps:property name="groupId" value="#{@commission.email.split('@').first}"></apps:property>
      <apps:property name="groupName" value="#{@commission.name}"></apps:property>
      <apps:property name="description" value="#{@commission.description}"></apps:property>
      <apps:property name="emailPermission" value="Anyone"></apps:property>
    </atom:entry>
             EOF
    @gapps.post("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl", post)
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
     gapps_login
     @gapps.delete("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl/#{commission.email.split('@').first}")
      commission.destroy
      flash[:success] = "Commissie Verwijderd"
      redirect_to commissions_path
  end
  
  private
  
  def admin_user
      redirect_to(commissions_path) unless current_user.admin?
    end
  
  
end