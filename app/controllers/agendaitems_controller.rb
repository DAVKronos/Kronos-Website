class AgendaitemsController < ApplicationController
  access_control do
         action :destroy do
           allow :admin
         end
         actions :index, :wedstrijden, :show, :showresults, :archief do
           allow all
         end
         actions :new, :create do
           allow logged_in
           allow :admin
         end
         actions :edit, :update, :newevents, :editevents, :newresults, :editresults do
           allow logged_in, :if => :user_in_commission?
           allow :admin
         end
     end

  
  def index
    @agendaitems = Agendaitem.where("date >= ?", Time.now).order("date ASC")
  end
  
  def wedstrijden
    @agendaitems = Agendaitem.where("date >= ? AND category LIKE ?", Time.now, '%wedstrijd%').order("date ASC")
    render :action => "index"
  end
  
  def archief
    @agendaitems = Agendaitem.order("date DESC")
    render :action => "index"
  end

  def new
    @agendaitem = Agendaitem.new
    @agendaitem.date = Time.now
    @agendaitem.subscriptiondeadline = Time.now
  end
  
  def newevents
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.events.build
    @agendaitem.events.build
    @agendaitem.events.build
    @agendaitem.events.build
    @agendaitem.events.build
  end
  
  def editevents
    @agendaitem = Agendaitem.find(params[:id])
  end
  
  def newresults
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.events.each do |event|
      @agendaitem.subscriptions.each do |subscription|
        result = event.results.build
        result.username = subscription.name
        if subscription.user
          result.user = subscription.user
        end
      end
    end
  end
  
  def show
    @agendaitem = Agendaitem.find(params[:id])
    
    if current_user
      @agendaitem.subscriptions.each do |subscr|
        if subscr.user == current_user
          @subscriptionbestaand = subscr
        end
      end
      if (defined?(@subscriptionbestaand)).nil?
        @subscription = Subscription.new
        @subscription.name = current_user.name.split[0]
        @subscription.agendaitem = @agendaitem
      end
    end
    
    @reaction = Reaction.new
    @reaction.agendaitem = @agendaitem
    if current_user
      @reaction.user = current_user
    end
  end
  
  def showresults
    @agendaitem = Agendaitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @result }
    end
  end

  def create
    @agendaitem = Agendaitem.new(params[:agendaitem])
    
    commissiont = Commission.last
    
    @agendaitem = commissiont.agendaitems.build(params[:agendaitem])
    
    respond_to do |format|
      if @agendaitem.save
        format.html { redirect_to :controller => "agendaitems", :action => "newevents", :id => @agendaitem.id, notice: 'Agendaitem was successfully created.' }
        format.json { render json: @agendaitem, status: :created, location: @agendaitem }
      else
        format.html { render action: "index" }
        format.json { render json: @agendaitem.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.destroy

    respond_to do |format|
      format.html { redirect_to agendaitems_path }
      format.json { head :ok }
    end
  end

  def edit
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.events.build
  end
  
  def editresults
    @agendaitem = Agendaitem.find(params[:id])
  end

  def update
    @agendaitem = Agendaitem.find(params[:id])

    respond_to do |format|
      if @agendaitem.update_attributes(params[:agendaitem])
        format.html { redirect_to edit_agendaitem_path(@agendaitem), notice: 'Agendaitem was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @agendaitem.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    
    def user_in_commission?
      @commission = Agendaitem.find(params[:id]).commission
      current_user.commissions.include?(@commission)
    end
end
