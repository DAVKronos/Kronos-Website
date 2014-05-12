class PhotoalbumsController < ApplicationController
  load_and_authorize_resource
  # GET /photoalbums
  # GET /photoalbums.json
  def index
    @photoalbums = Photoalbum.includes('agendaitem').order("case when agendaitems is null then photoalbums.created_at else agendaitems.date end DESC").paginate(:page => params[:page], :per_page => 12)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photoalbums }
    end
  end

  # GET /photoalbums/1
  # GET /photoalbums/1.json
  def show
    @photoalbum = Photoalbum.find(params[:id])
	@allphotos = @photoalbum.photos.all(:order => 'created_at DESC')
    @photos = @photoalbum.photos.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 12)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photoalbum }
    end
  end

  # GET /photoalbums/new
  # GET /photoalbums/new.json
  def new
    @photoalbum = Photoalbum.new
    @agendaitems = Agendaitem.order("date DESC").limit("50")
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photoalbum }
    end
  end

  # GET /photoalbums/1/edit
  def edit
    @photoalbum = Photoalbum.find(params[:id])
  end

  # POST /photoalbums
  # POST /photoalbums.json
  def create
    @photoalbum = Photoalbum.new(params[:photoalbum])

    respond_to do |format|
      if @photoalbum.save
        format.html { redirect_to edit_photoalbum_path @photoalbum, notice: 'Photoalbum was successfully created.' }
        format.json { render json: @photoalbum, status: :created, location: @photoalbum }
      else
        format.html { render 'new' }
        format.json { render json: @photoalbum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photoalbums/1
  # PUT /photoalbums/1.json
  def update
    @photoalbum = Photoalbum.find(params[:id])

    respond_to do |format|
      if @photoalbum.update_attributes(params[:photoalbum])
        format.html { redirect_to @photoalbum, notice: 'Photoalbum was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @photoalbum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photoalbums/1
  # DELETE /photoalbums/1.json
  def destroy
    @photoalbum = Photoalbum.find(params[:id])
    @photoalbum.destroy

    respond_to do |format|
      format.html { redirect_to photoalbums_url }
      format.json { head :ok }
    end
  end
end
