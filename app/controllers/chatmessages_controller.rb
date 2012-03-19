class ChatmessagesController < ApplicationController
  load_and_authorize_resource
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
        format.html { redirect_to chatmessages_path 
                      flash[:success] = "Chatmessage was successfully created." 
                    }
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
      @chatmessage.destroy

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
