class AgendaitemsController < ApplicationController
  access_control do
         action :destroy do
           allow :admin
         end
         actions :index, :show, :showresults do
           allow all
         end
         actions :edit, :update, :new, :create, :newevents, :editevents, :newresults, :editresults do
           allow logged_in, :if => :user_in_commission?
           allow :admin
         end
     end

  
  def index
    @agendaitems = Agendaitem.all
  end

  def new
    @agendaitem = Agendaitem.new
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
    
    @subscription = Subscription.new
    @subscription.agendaitem = @agendaitem
    if current_user
      @subscription.name = current_user.name.split[0]
    end
    
    @reaction = Reaction.new
    @reaction.agendaitem = @agendaitem
    if current_user
      @reaction.user = current_user
    end
    
    if @agendaitem.category == 'Kronoswedstrijd'
      render :action => "wedstrijdshow"
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
