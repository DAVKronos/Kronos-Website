class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def index
    #@results = Result.all
    
    @slicedresults = Array.new

    @slicedresults[0] = ["Laatste", Result.where(:created_at => (DateTime.now() - 1.year)..(DateTime.now()))]
    @slicedresults[1] = ["2012", Result.where(:created_at => (DateTime.now() - 1.year)..(DateTime.now()))]
    @slicedresults[2] = ["2011", Result.where(:created_at => (DateTime.now() - 1.year)..(DateTime.now()))]
    @slicedresults[3] = ["2010", Result.where(:created_at => (DateTime.now() - 1.year)..(DateTime.now()))]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end
end