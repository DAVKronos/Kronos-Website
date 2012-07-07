class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def frontpage
    #@results = Result.all
    
    @slicedresults = Array.new
    @matches = Agendaitem.joins(:agendaitemtype).where(:agendaitemtypes => {:is_match => true}).order('date DESC')

    @slicedresults[0] = ["Laatste", @matches.where("date <= ?", DateTime.now).limit(20)]
    currentyear = DateTime.now.year
    
    tussenresult = [Date.new(currentyear).year.to_s, @matches.where(:date => (Date.new(currentyear)..DateTime.now()))]
    if !tussenresult.last.empty?
      @slicedresults[1] = tussenresult
    end
    
    (2..6).each do |i|
      tussenresult = [Date.new(currentyear - i + 1).year.to_s, @matches.where(:date => (Date.new(currentyear - i + 1)..Date.new(currentyear - i + 2)))]
      if !tussenresult.last.empty?
        @slicedresults[i] = tussenresult
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end
  
  def index
    @agendaitem = Agendaitem.find(params[:agendaitem_id])
    
    respond_to do |format|
      format.html
    end
  end
end