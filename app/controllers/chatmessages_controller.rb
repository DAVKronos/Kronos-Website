class ChatmessagesController < ApplicationController
  
  access_control do
         actions :destroy do
           allow :admin
         end
         actions :index, :archief, :new, :create do
           allow all
         end
         actions :edit, :update do
           allow logged_in, :if => :user_current_user?
           allow :admin
         end
     end
  # GET /chatmessages
  # GET /chatmessages.json
  def index
    @chatmessage = Chatmessage.new
    @chatmessages = Chatmessage.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 10)
    
    if current_user
      @chatmessage.by = current_user.name.split[0]
      @chatmessage.email = current_user.email
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chatmessages }
    end
  end
  
  def archief
    @chatmessages = Chatmessage.all
  end

  # GET /chatmessages/1/edit
  def edit
    @chatmessage = Chatmessage.find(params[:id])
    if @chatmessage.allow_edit?(current_user)
    else
      redirect_to chatmessages_path, notice: 'You have no rights to edit this message'
    end
  end

  # POST /chatmessages
  # POST /chatmessages.json
  def create
    @chatmessage = Chatmessage.new(params[:chatmessage])

    if current_user
      @chatmessage = current_user.chatmessages.build(params[:chatmessage])
    end

    respond_to do |format|
      if humanCheck && @chatmessage.save
        format.html { redirect_to chatmessages_path, notice: 'Chatmessage was successfully created.' }
        format.json { render json: @chatmessage, status: :created, location: @chatmessage }
      else
        format.html { redirect_to chatmessages_path }
        format.json { render json: @chatmessage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chatmessages/1
  # PUT /chatmessages/1.json
  def update
    @chatmessage = Chatmessage.find(params[:id])
    if @chatmessage.allow_edit?(current_user)
    else
      redirect_to chatmessages_path, notice: 'You have no rights to edit this message'
    end
    respond_to do |format|
      if @chatmessage.update_attributes(params[:chatmessage])
        format.html { redirect_to chatmessages_path, notice: 'Chatmessage was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @chatmessage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatmessages/1
  # DELETE /chatmessages/1.json
  def destroy
    @chatmessage = Chatmessage.find(params[:id])
    if @chatmessage.allow_destroy?(current_user)
      @chatmessage.destroy
    else
      redirect_to chatmessages_path, notice: 'You have no rights to destroy this message'
    end

    respond_to do |format|
      format.html { redirect_to chatmessages_path }
      format.json { head :ok }
    end
  end
  
  private
  
    def humanCheck
      if current_user
        true
      else
        verify_recaptcha
      end
    end
    
    def user_current_user?
      @user = Chatmessage.find(params[:id]).user
      current_user?(@user)
    end
  
end
