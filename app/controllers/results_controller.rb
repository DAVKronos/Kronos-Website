class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def frontpage
    #@results = Result.all
    if request.xhr?
      ajaxladen = params[:ajaxladen]
      if ajaxladen == 'Laatste'
        @results = Agendaitem.where("date <= ?", DateTime.now).limit(20)
      else
        @results = Agendaitem.where(:date => (DateTime.new(Integer(ajaxladen))..(DateTime.new(Integer(ajaxladen))+1.year)))
      end
    else
      @results = Agendaitem.where("date <= ?", DateTime.now).limit(20)
      @tabs = [2012, 2011, 2010, 2009, 2008];
    end
    
    respond_to do |format|
      format.html do
        if request.xhr?
          render 'results/tabtable', :layout => false
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
end