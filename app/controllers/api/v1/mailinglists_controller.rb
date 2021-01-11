class MailinglistsController < Api::V1::ApplicationController
  load_and_authorize_resource

  def index
    @mailinglists = Mailinglist.all
  end

  def show
    @mailinglist = Mailinglist.find(params[:id])
  end

  def new
    @mailinglist = Mailinglist.new
    @users = User.order(:name)
    @aliases = Alias.order(:name)
    @mailinglists = Mailinglist.all
  end

  def edit
    @mailinglist = Mailinglist.find(params[:id])
    @users = @mailinglist.get_possible_users
    @aliases = Alias.order(:name)
    @mailinglists = Mailinglist.all
  end

  def create
    mailinglist = Mailinglist.new(mailinglist_params)
    if mailinglist.save
      redirect_to mailinglist
    else
      @mailinglist = mailinglist
      @users = User.order(:name)
      @aliases = Alias.order(:name)
      @mailinglists = Mailinglist.all
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
    if @mailinglist.update_attributes(mailinglist_params)
      flash[:success] = t(:mailinglist_update_success)
      redirect_to Mailinglist
    else
      @users = User.order(:name)
      render 'edit'
    end
  end

  private

  def mailinglist_params
    params.require(:mailinglist).permit(:description, :name, :local_part, :mailinglist_memberships_attributes, :commission_id, user_ids: [], alias_ids: [], )
  end
end
