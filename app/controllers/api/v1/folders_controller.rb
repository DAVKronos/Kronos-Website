module Api
  module V1
    class FoldersController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        if params[:folder_id]
          folders = Folder.order(:name)
          folders = folders.where.not(id: params[:folder_id])
          folders = folders.where.not(folder_id: params[:folder_id]).or(folders.where(folder_id: [nil, ""]))
        else
          folders = Folder.where(folder_id: [nil, ""]).order(:name)
        end 

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
        params.require(:folder).permit(:name, :folder_id)
      end
    end
  end
end
