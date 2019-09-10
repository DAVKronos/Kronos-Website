class AgendaitemtypeEventtypesController < ApplicationController
  load_and_authorize_resource
  # GET /agendaitemtype_eventtypes
  # GET /agendaitemtype_eventtypes.json
  def index
    @agendaitemtype_eventtypes = AgendaitemtypeEventtype.order(:agendaitemtype_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agendaitemtype_eventtypes }
    end
  end

  # GET /agendaitemtype_eventtypes/1
  # GET /agendaitemtype_eventtypes/1.json
  def show
    @agendaitemtype_eventtype = AgendaitemtypeEventtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agendaitemtype_eventtype }
    end
  end

  # GET /agendaitemtype_eventtypes/new
  # GET /agendaitemtype_eventtypes/new.json
  def new
    @agendaitemtype_eventtype = AgendaitemtypeEventtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agendaitemtype_eventtype }
    end
  end

  # GET /agendaitemtype_eventtypes/1/edit
  def edit
    @agendaitemtype_eventtype = AgendaitemtypeEventtype.find(params[:id])
  end

  # POST /agendaitemtype_eventtypes
  # POST /agendaitemtype_eventtypes.json
  def create
    @agendaitemtype_eventtype = AgendaitemtypeEventtype.new(params[:agendaitemtype_eventtype])

    respond_to do |format|
      if @agendaitemtype_eventtype.save
        format.html { redirect_to @agendaitemtype_eventtype, notice: 'Agendaitemtype eventtype was successfully created.' }
        format.json { render json: @agendaitemtype_eventtype, status: :created, location: @agendaitemtype_eventtype }
      else
        format.html { render action: "new" }
        format.json { render json: @agendaitemtype_eventtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /agendaitemtype_eventtypes/1
  # PUT /agendaitemtype_eventtypes/1.json
  def update
    @agendaitemtype_eventtype = AgendaitemtypeEventtype.find(params[:id])

    respond_to do |format|
      if @agendaitemtype_eventtype.update_attributes(params[:agendaitemtype_eventtype])
        format.html { redirect_to @agendaitemtype_eventtype, notice: 'Agendaitemtype eventtype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agendaitemtype_eventtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agendaitemtype_eventtypes/1
  # DELETE /agendaitemtype_eventtypes/1.json
  def destroy
    @agendaitemtype_eventtype = AgendaitemtypeEventtype.find(params[:id])
    @agendaitemtype_eventtype.destroy

    respond_to do |format|
      format.html { redirect_to agendaitemtype_eventtypes_url }
      format.json { head :no_content }
    end
  end


  private

  def agendaitemtype_eventtype_params
    params.require(:agendaitemtype_eventtype).permit(:agendaitemtype_id, :eventtype_id)
  end
end
