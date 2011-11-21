class CommissionMembershipsController < ApplicationController
  def new
    @commission_membership = CommissionMembership.new
  end

  def create
    @commission_membership = CommissionMembership.new(params[:commission_membership])
    if @commission_membership.save
      post = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
      <atom:entry xmlns:atom="http://www.w3.org/2005/Atom"
          xmlns:apps="http://schemas.google.com/apps/2006"
          xmlns:gd="http://schemas.google.com/g/2005">
          <apps:property name="memberId" value="#{@commission_membership.user.email}"/>
      </atom:entry>
      EOF
      gapps_login
      @gapps.post("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl/#{@commission_membership.commission.email.split("@").first}/member",post)
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
     gapps_login
     @gapps.delete("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl/#{commission_membership.commission.email.split("@").first}/member/#{commission_membership.user.email}")
      commission_membership.destroy
      flash[:success] = "#{commission_membership.user.name} Verwijderd"
      redirect_to commissions_path
  end

end
