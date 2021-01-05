
module Api
  module V1
    class ApplicationController < ::ApplicationController
      skip_before_action :verify_authenticity_token
      include DeviseTokenAuth::Concerns::SetUserByToken

      rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
          format.json { head :forbidden }
          format.html { redirect_to main_app.root_url, :alert => exception.message }
        end
      end

      rescue_from ActionController::ParameterMissing do |e|
        render json: { message: e.message },  status: :bad_request
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({ message: e.message }, :not_found)
      end
    end
  end
end