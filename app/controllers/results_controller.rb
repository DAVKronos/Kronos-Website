class ResultsController < ApplicationController
  load_and_authorize_resource
  
  def index
    if date_params_set?
      @date = Date.new(params[:date][:year].to_i, 
                       params[:date][:month].to_i)
    else 
      @date = Date.today 
    end
 
    @agendaitems = Agendaitem.joins("LEFT OUTER JOIN events ON events.agendaitem_id = agendaitems.id")
      .joins("LEFT OUTER JOIN results ON results.event_id = events.id")
      .where(:date => @date.beginning_of_month..@date.end_of_month)
      .where("results.id IS NOT NULL")
      .group('agendaitems.id')
      .order("date ASC")
  end
  
  def records
    index
	
    @eventtypes = Eventtype.where(:important=>true)
  end
  
  def new
    @agendaitems = Agendaitem.joins(:agendaitemtype).where(:agendaitemtypes => {:is_match => true}).order('date DESC')
  end
  
  def create
    event = Event.find(params[:result][:event_id])
    result = event.results.build(result_params)
    result.save
    if request.xhr?
      render 'results/_show', :layout => false, :locals => {:event => result.event}
    else
      redirect_to agendaitem_events_path(event.agendaitem)
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

private

  def result_params
    # TODO controller now permits all models attributes, try to be more specific
    params.require(:result).permit!
  end

  def date_params_set?
		return params[:date].present? && params[:date][:year].present? && params[:date][:month].present?
	end	
	
end
