class EventsController < ApplicationController
  load_and_authorize_resource
  # GET /events
  # GET /events.json
  def index
    @agendaitem = Agendaitem.find(params[:agendaitem_id])
    @events = @agendaitem.events
    @event = Event.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events.map{|event| event.as_json(include: :results)} }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event.as_json(include: :results) }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @event.results.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @event.results.build
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html do
          if request.xhr?
            render :partial => "results/show", :locals => { :event => @event }, :layout => false, :status => :created
          else
          redirect_to agendaitem_events_path(@event.agendaitem), notice: 'Event was successfully created.'
          end
        end
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])
	
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html do
          if request.xhr?
            render :partial => "results/show", :locals => { :event => @event }, :layout => false, :status => :created
          else
            redirect_to @event
          end
        end
      else
        format.html do
          if request.xhr?
            render :json => @event.errors, :status => :unprocessable_entity
          else
            render :action => :edit, :status => :unprocessable_entity
          end
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    agendaitem = @event.agendaitem
    @event.destroy

    if(agendaitem)
      respond_to do |format|
        format.html { redirect_to agendaitem_events_path(agendaitem) }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :ok }
      end
    end
  end

  private

  def event_params
    # TODO controller now permits all models attributes, try to be more specific
    params.require(:event).permit!
  end
end
