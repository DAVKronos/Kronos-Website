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

  def create
    mailinglist = Mailinglist.new(params[:mailinglist])
    if mailinglist.save
      redirect_to mailinglist
    else
      @mailinglists = mailinglist
      render 'new'
    end
  end

  def destroy
  end

  def update
  end
end
