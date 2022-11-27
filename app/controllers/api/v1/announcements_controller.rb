module Api
  module V1
class AnnouncementsController < Api::V1::ApplicationController

  load_and_authorize_resource


  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.all

    respond_to do |format|
      format.json { render json: @announcements }
    end
  end

  def current
    if params[:hidden_ids]
      announcements = Announcement.current(params[:hidden_ids])
    else
      announcements = Announcement.current
    end
    respond_to do |format|
      format.json { render json: announcements.as_json(methods: [:background_url]) }
    end
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      format.json { render json: @announcement }
    end
  end


  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.json { render json: @announcement, status: :created }
      else
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /announcements/1
  # PUT /announcements/1.json
  def update
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      if @announcement.update_attributes(announcement_params)
        format.json { head :no_content }
      else
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :message, :ends_at, :starts_at, :url, :background)
  end
end
end
end
