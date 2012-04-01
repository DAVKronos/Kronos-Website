class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def index
    #@results = Result.all
    
    @slicedresults = Array.new

    @slicedresults[0] = ["Laatste", Agendaitem.where("date <= ?", DateTime.now).limit(20)]
    currentyear = DateTime.now.year
    
    tussenresult = [Date.new(currentyear).year.to_s, Agendaitem.where(:date => (Date.new(currentyear - 1)..DateTime.now()))]
    if !tussenresult.last.empty?
      @slicedresults[1] = tussenresult
    end
    
    (2..10).each do |i|
      tussenresult = [Date.new(currentyear - i + 1).year.to_s, Agendaitem.where(:date => (Date.new(currentyear - i)..Date.new(currentyear - i + 2)))]
      if !tussenresult.last.empty?
        @slicedresults[i] = tussenresult
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end
end