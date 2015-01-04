class MailinglistsController < ApplicationController
  load_and_authorize_resource

  def index
    @mailinglists = Mailinglist.all
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  def update
  end
end
