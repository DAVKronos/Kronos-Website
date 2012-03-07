class ReactionsController < ApplicationController
  # GET /reactions
  # GET /reactions.json
  def index
    @reactions = Reaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reactions }
    end
  end

  # GET /reactions/1
  # GET /reactions/1.json
  def show
    @reaction = Reaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reaction }
    end
  end

  # GET /reactions/new
  # GET /reactions/new.json
  def new
    @reaction = Reaction.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reaction }
    end
  end

  # GET /reactions/1/edit
  def edit
    @reaction = Reaction.find(params[:id])
  end

  # POST /reactions
  # POST /reactions.json
  def create
    @reaction = Reaction.new(params[:reaction])

    respond_to do |format|
      if @reaction.save
        format.html { redirect_to @reaction, notice: 'Reaction was successfully created.' }
        format.json { render json: @reaction, status: :created, location: @reaction }
      else
        format.html { render action: "new" }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reactions/1
  # PUT /reactions/1.json
  def update
    @reaction = Reaction.find(params[:id])

    respond_to do |format|
      if @reaction.update_attributes(params[:reaction])
        format.html { redirect_to @reaction, notice: 'Reaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reactions/1
  # DELETE /reactions/1.json
  def destroy
    @reaction = Reaction.find(params[:id])
    @reaction.destroy

    respond_to do |format|
      format.html { redirect_to reactions_url }
      format.json { head :ok }
    end
  end
end
