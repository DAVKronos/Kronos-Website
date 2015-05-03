class MailinglistsController < ApplicationController
  load_and_authorize_resource

  def index
    @mailinglists = Mailinglist.all
  end

  def show
    @mailinglist = Mailinglist.find(params[:id])
  end

  def new
    @mailinglist = Mailinglist.new
  end

  def edit
    @mailinglist = Mailinglist.find(params[:id])
    User.all.each do |user|
      unless @mailinglist.mailinglist_memberships.find_by_user_id(user.id)
        membership = @mailinglist.mailinglist_memberships.new
        membership.user = user
      end
    end
  end

  def create
    mailinglist = Mailinglist.new(params[:mailinglist])
    if mailinglist.save
      redirect_to mailinglist
    else
      @mailinglist = mailinglist
      render 'new'
    end
  end

  def destroy
    mailinglist = Mailinglist.find(params[:id])
    if mailinglist.destroy
      flash[:success] = t(:mailinglist_destroy_success)
    else
      flash[:error] = t(:mailinglist_destroy_failure)
    end
    redirect_to Mailinglist
  end

  def update
    @mailinglist = Mailinglist.find(params[:id])
    if @mailinglist.update_attributes(params[:mailinglist])
      flash[:success] = t(:mailinglist_update_success)
      redirect_to Mailinglist
    else
      render 'edit'
    end
  end
end
