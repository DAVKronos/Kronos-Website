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
        @results = Agendaitem.where(Date.strptime(:date, "%Y-%m-%d %H:%M:%S").year == ajaxladen)
      end
    else
      @results = Agendaitem.where("date <= ?", DateTime.now).limit(20)
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
      format.html
    end
  end
end