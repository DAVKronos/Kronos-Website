class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @agendaitem = Agendaitem.find(params[:agendaitem_id])
    @subscriptions = @agendaitem.subscriptions
    @subscription = @subscriptions.build

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @agendaitem = Agendaitem.find(params[:agendaitem_id])
	@subscription = @agendaitem.subscriptions.build(params[:subscription])

    respond_to do |format|
      if @subscription.save
	  	# send a mail
		CommissionMailer.subscription_email(@subscription.agendaitem, current_user).deliver

        format.html { redirect_to agendaitem_path(@subscription.agendaitem), notice: 'Subscription was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    agendaitem = @subscription.agendaitem
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to agendaitem }
      format.json { head :ok }
    end
  end
end
