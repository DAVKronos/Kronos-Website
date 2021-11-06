module Api
  module V1
    class PhotosController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        @photos = Photoalbum.find(params[:photoalbum_id]).photos.order('exif_date ASC, photo_file_name ASC, created_at ASC')
        render json: @photos.collect { |p| p.as_json(methods: [:photo_url_original, :photo_url_thumb]) }
      end

      def create
        @photo = Photoalbum.find(params[:photoalbum_id]).photos.build(photo_params)

        if @photo.photo.content_type == "image/jpeg"
          exif = EXIFR::JPEG.new(params[:photo][:photo].path)
          @photo.exif_date = exif.date_time
        end

        if @photo.save
          respond_to do |format|
            format.json {
              render json:  @photo.to_json_with_urls
            }
          end
        else
          render :json => [{:error => "custom_failure"}], :status => 304
        end
      end

      def random
        @photo = Photoalbum.find(params[:photoalbum_id]).photos.order(Arel.sql('RANDOM()')).first

        render json: @photo.to_json_with_urls
      end

      def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
        respond_to do |format|
          format.json { head :ok }
        end
      end

      private

      def photo_params
        # TODO controller now permits all models attributes, try to be more specific
        params.require(:photo).permit!
      end
    end
  end
end