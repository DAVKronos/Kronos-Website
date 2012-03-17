class ResultsController < ApplicationController
  # GET /results
  # GET /results.json
  def index
    @results = Agendaitem.find(params[:agendaitem_id]).results.paginate(:page => params[:page], :order => 'updated_at DESC', :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end
end