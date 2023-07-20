module Api
  module V1
    class KronometersController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        kms = Kronometer.order('date DESC')

        if current_user.nil?
          kms = kms.where(public: true)
        end

        if params[:folder_id]
          kms = kms.where(folder_id: params[:folder_id])
        else
          kms = kms.where(folder_id: [nil, "", 0])
        end

        respond_to do |format|
          format.json { render json: kms.collect {|km| km.as_json(methods: [:url_original, :url_thumb])} }
        end
      end

      def show
        kronometer = Kronometer.find(params[:id])
        respond_to do |format|
          format.json { render json: kronometer }
        end
      end

      def create
        kronometer = Kronometer.new(kronometer_params)
        if kronometer.save
          render json: kronometer
        else
          render json: {message: kronometer.errors.full_messages}, status: :bad_request
        end
      end
    
      def update
        kronometer = Kronometer.find(params[:id])
        if kronometer.update(kronometer_params)
          render json: kronometer
        else
          render json: {message: kronometer.errors.full_messages}, status: :bad_request
        end
      end
    
      def destroy
        kronometer = Kronometer.find(params[:id])
        if kronometer.destroy
          respond_to do |format|
            format.json { head :ok }
          end
        else
          render json: {message: kronometer.errors.full_messages}, status: :bad_request
        end
      end

      def labels
        @users = User.where(:papieren_kronometer => true)

        respond_to do |format|
          format.pdf do
            render :pdf => "kronometer stickers #{Time.now}"
          end
        end
      end

      def display
        @kronometer = Kronometer.find(params[:id])
        send_file @kronometer.file.path(params[:style]), :disposition => 'inline'
      end

      private

      def kronometer_params
        params.require(:kronometer).permit(:date, :file, :name, :folder_id, :public)
      end
    end
  end
end
