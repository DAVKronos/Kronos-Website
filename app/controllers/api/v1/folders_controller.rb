module Api
  module V1
    class FoldersController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        folders = Folder.where(folder_id: [nil, ""]).order(:name)
        respond_to do |format|
          format.json { render json: folders.as_json }
        end
      end

      def show
        folder = Folder.find(params[:id])
        respond_to do |format|
          format.json { render json: folder.as_json(include: :folders) }
        end
      end

      def create
        folder = Folder.new(folder_params)
        if folder.save
          render json: folder
        else
          render json: {message: folder.errors.full_messages}, status: :bad_request
        end
      end
    
      def update
        folder = Folder.find(params[:id])
        if folder.update(folder_params)
          render json: folder
        else
          render json: {message: folder.errors.full_messages}, status: :bad_request
        end
      end
    
      def destroy
        folder = Folder.find(params[:id])
        if folder.destroy
          respond_to do |format|
            format.json { head :ok }
          end
        else
          render json: {message: folder.errors.full_messages}, status: :bad_request
        end
      end


      def folder_params
        # TODO controller now permits all models attributes, try to be more specific
        params.require(:folder).permit!
      end
    end
  end
end
