class AppsExceptionsController < ApplicationController
  load_and_authorize_resource
  
  # GET /apps_exceptions
  # GET /apps_exceptions.json
  def index
    @apps_exceptions = AppsException.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apps_exceptions }
    end
  end

  # GET /apps_exceptions/1
  # GET /apps_exceptions/1.json
  def show
    @apps_exception = AppsException.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @apps_exception }
    end
  end

  # GET /apps_exceptions/new
  # GET /apps_exceptions/new.json
  def new
    @apps_exception = AppsException.new

	if params['group'] && params['mail'] && params['way'] then
		@apps_exception = AppsException.where("email = ? AND group_email = ?", params['mail'], params['group']).first
		if @apps_exception then
			@apps_exception.destroy
		else
		    @apps_exception = AppsException.new
			@apps_exception.group_email = params['group']
			@apps_exception.email = params['mail']
			@apps_exception.way = params['way']
			@apps_exception.save
		end
		
		redirect_to url_for :controller => 'kronobox', :action => 'appshome'
		return
	end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @apps_exception }
    end
  end

  # GET /apps_exceptions/1/edit
  def edit
    @apps_exception = AppsException.find(params[:id])
  end

  # POST /apps_exceptions
  # POST /apps_exceptions.json
  def create
    @apps_exception = AppsException.new(params[:apps_exception])

    respond_to do |format|
      if @apps_exception.save
        format.html { redirect_to @apps_exception, notice: 'Apps exception was successfully created.' }
        format.json { render json: @apps_exception, status: :created, location: @apps_exception }
      else
        format.html { render action: "new" }
        format.json { render json: @apps_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apps_exceptions/1
  # PUT /apps_exceptions/1.json
  def update
    @apps_exception = AppsException.find(params[:id])

    respond_to do |format|
      if @apps_exception.update_attributes(params[:apps_exception])
        format.html { redirect_to @apps_exception, notice: 'Apps exception was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @apps_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps_exceptions/1
  # DELETE /apps_exceptions/1.json
  def destroy
    @apps_exception = AppsException.find(params[:id])
    @apps_exception.destroy

    respond_to do |format|
      format.html { redirect_to apps_exceptions_url }
      format.json { head :no_content }
    end
  end
end
