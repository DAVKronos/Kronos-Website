module Api
  module V1
    class AbilitiesController < Api::V1::ApplicationController
      load_and_authorize_resource
      respond_to :json

      def index
        render json: current_ability.to_list
      end
    end

  end
end
