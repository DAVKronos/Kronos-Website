class ResultsController < ApplicationController
  # GET /results
  # GET /results.json
  def index
    @agendaitems = Agendaitem.all
    @results = Result.paginate(:page => params[:page], :order => 'updated_at DESC', :per_page => 10)
    
    @results.each do |result|
        expressie1 = result.event.eventtype.calculation.gsub('r', result.result.to_s)
        expressie = expressie1.gsub('d', result.event.distance.to_s)
        result.timetoseconds(expressie)
        result.calculated = result.stringcal(expressie)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end
  
  def list
    @results = Result.all
  end
  
  def show
    @result = Result.find(params[:id])
    
    @reaction = Reaction.new
    @reaction.result = @result
    if current_user
      @reaction.user = current_user
    end
  end

  # GET /results/1/edit
  def edit
    @result = Result.find(params[:id])
  end

  # PUT /results/1
  # PUT /results/1.json
  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result = Result.find(params[:id])
    event = @result.event
    @result.destroy

    respond_to do |format|
      format.html { redirect_to edit_event_path(event) }
      format.json { head :ok }
    end
  end
end
