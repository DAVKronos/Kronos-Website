class AgendaitemsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @agendaitems = Agendaitem.where("date >= ?", Time.now).paginate(:page => params[:page], :order => 'date ASC', :per_page => 10)
  end
  
  def wedstrijden
    @agendaitems = Agendaitem.where("date >= ?", Time.now).order('date ASC').paginate(:page => params[:page], :per_page => 10)
    @agendaitems.delete_if{|x| x.agendaitemtype.is_match = false }
    render :action => "index"
  end
  
  def archief
    @agendaitems = Agendaitem.paginate(:page => params[:page], :order => 'date DESC', :per_page => 10)
    
    render :action => "index"
  end

  def new
    @agendaitem = Agendaitem.new
    @agendaitem.date = Time.now
    @agendaitem.subscriptiondeadline = Time.now
    @commissions = current_user.admin? ? Commission.all : current_user.commissions
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

  def create
    @agendaitem = Agendaitem.new(params[:agendaitem])
    
    respond_to do |format|
      if @agendaitem.save
        format.html { redirect_to @agendaitem, notice: 'Agendaitem was successfully created.' }
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
    @commissions = current_user.admin? ? Commission.all : current_user.commissions
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
  

end
