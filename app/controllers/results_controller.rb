class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def frontpage
    if (params[:year].nil? || params[:month].nil?) then
      date = Date.today
    else
      begin
        date = DateTime.new(params[:year].to_i,params[:month].to_i)
      rescue ArgumentError
        date = Date.today
        redirect_to '/uitslagen/'
      end
    end
    
    earliest = Agendaitem.first(:order => 'date asc').date.to_date
    if earliest.year < 1964 then
      earliest = Date.new(1964, 1)
    end
    latest = Agendaitem.last(:order=>'date asc').date.to_date
    if latest < date
        date = latest
    end
    range = Array.new
 
    (earliest.year..latest.year).each do |y|
      mo_start = (earliest.year == y) ? earliest.month : 1
      mo_end = (latest.year == y) ? latest.month : 12
      (mo_start..mo_end).each do |m|  
        range << [y,m]
      end
    end 
    
    before, after = range.partition {|e| (Date.new(e.first,e.second) < date.beginning_of_month ) }
    after = after.drop(1)
    
    @agendaitems = Agendaitem.where(:date => date.beginning_of_month..date.next_month).order("date ASC")
    @years = range.map{|e| e.first}.uniq

    @past = before.map{|e| Date.new(e.first,e.second)}
    @present = after.map{|e| Date.new(e.first,e.second)}
    @current = date.beginning_of_month
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
end
