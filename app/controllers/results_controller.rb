class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def frontpage
    #@results = Result.all
    if request.xhr?
      ajaxladen = params[:ajaxladen]
      if ajaxladen == 'Laatste'
        @results = Agendaitem.joins(:agendaitemtype).where("date <= ?", DateTime.now).order("date DESC").limit(40)
		@results.delete_if {|re| re.count_results() == 0}
      elsif ajaxladen == 'Toevoegen'
        @results = Agendaitem.joins(:agendaitemtype).where("date <= ?", DateTime.now).order("date DESC").limit(40)
		@results.delete_if {|re| re.count_results() != 0}
	  else
        @results = Agendaitem.joins(:agendaitemtype).where(:date => (DateTime.new(Integer(ajaxladen))..(DateTime.new(Integer(ajaxladen))+1.year))).order("date DESC")
		@results.delete_if {|re| re.count_results() == 0}
      end
    else
      @results = Agendaitem.joins(:agendaitemtype).where("date <= ?", DateTime.now).order("date DESC").limit(40)
      @results.delete_if {|re| re.count_results() == 0}
      @tabs = []
      counter = 0
      5.times do
        @tabs << counter.year.ago.year
        counter += 1
      end
    end
	    
    respond_to do |format|
      format.html do
        if request.xhr?
          render 'results/_tabtable', :layout => false
        end
      end
    end
  end
  
  def index
    @agendaitem = Agendaitem.find(params[:agendaitem_id])
    
    respond_to do |format|
      format.html do
        if request.xhr?
          render 'results/indextab', :layout => false
        end
      end
    end
  end
  
  def new
    @agendaitems = Agendaitem.joins(:agendaitemtype).where(:agendaitemtypes => {:is_match => true}).order('date DESC')
  end
  
  def create
    event = Event.find(params[:event_id])
    result = event.results.build(params[:result])
    result.save
    if request.xhr?
      render 'results/_show', :layout => false, :locals => {:event => Event.find(event.id)}
    end
  end
  
  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    respond_to do |format|
      format.html { redirect_to agendaitem_events_path(@result.event.agendaitem) }
      format.json {
        render :json => true
      }
    end
  end
end