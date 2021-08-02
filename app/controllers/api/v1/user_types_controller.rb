module Api
  module V1
    class UserTypesController < Api::V1::ApplicationController
      load_and_authorize_resource
      # GET /usertypes
      # GET /usertypes.json
      def index
        @usertypes = UserType.all

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @usertypes }
        end
      end
    end
  end
end
