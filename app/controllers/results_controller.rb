class ResultsController < ApplicationController
  load_and_authorize_resource
  # GET /results
  # GET /results.json
  def index
    @results = Result.paginate(:page => params[:page], :order => 'updated_at DESC', :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end
end