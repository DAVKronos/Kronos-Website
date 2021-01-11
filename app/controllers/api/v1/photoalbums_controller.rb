module Api
  module V1
    class PhotoalbumsController < Api::V1::ApplicationController
      load_and_authorize_resource
      # GET /photoalbums
      # GET /photoalbums.json
      def index
        @photoalbums = Photoalbum.order(Arel.sql('eventdate DESC NULLS LAST, created_at DESC ')).includes(:agendaitem)

        if current_user.nil?
          @photoalbums = @photoalbums.where(public: true)
        end
        respond_to do |format|
          format.json { render json: @photoalbums }
        end
      end

      # GET /photoalbums/1
      # GET /photoalbums/1.json
      def show
        @photoalbum = Photoalbum.find(params[:id])

        @allphotos = @photoalbum.photos.all.order('exif_date ASC, photo_file_name ASC, created_at ASC')

        respond_to do |format|
          format.json { render json: @photoalbum.as_json }
        end
      end

      # GET /photoalbums/new
      # GET /photoalbums/new.json
      def new
        @photoalbum = Photoalbum.new

        respond_to do |format|
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
        @photoalbum = Photoalbum.new(photoalbum_params)

        respond_to do |format|
          if @photoalbum.save
            format.html { redirect_to edit_photoalbum_path @photoalbum, notice: 'Photoalbum was successfully created.' }
            format.json { render json: @photoalbum, status: :created }
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
          if @photoalbum.update_attributes(photoalbum_params)
            format.html { redirect_to @photoalbum, notice: 'Photoalbum was successfully updated.' }
            format.json { render json:@photoalbum }
          else
            format.html { render action: "edit" }
            format.json { render json: @photoalbum.errors, status: :unprocessable_entity }
          end
        end
      end

      # GET /photoalbums/1/publish
      def publish
        @photoalbum = Photoalbum.find(params[:id])

        @photoalbum.public = !@photoalbum.public

        @photoalbum.save

        redirect_to @photoalbum, notice: 'Photoalbum was successfully published.'
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

      private

      def photoalbum_params
        if current_user.admin?
          params.require(:photoalbum).permit(:name, :name_en, :agendaitem_id, :public, :eventdate)
        else
          params.require(:photoalbum).permit(:name, :name_en, :agendaitem_id, :eventdate)
        end

      end
    end
  end
end
