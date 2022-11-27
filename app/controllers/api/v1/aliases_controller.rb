module Api
  module V1
    class AliasesController < Api::V1::ApplicationController
      load_and_authorize_resource

      # GET /aliases
      # GET /aliases.json
      def index
        @aliases = Alias.all

        render json: @aliases
      end

      # GET /aliases/1
      # GET /aliases/1.json
      def show
        @alias = Alias.find(params[:id])

        render json: @alias
      end

      # GET /aliases/new
      # GET /aliases/new.json
      def new
        @alias = Alias.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @alias }
        end
      end

      # GET /aliases/1/edit
      def edit
        @alias = Alias.find(params[:id])
      end

      # POST /aliases
      # POST /aliases.json
      def create
        @alias = Alias.new(alias_params)

        respond_to do |format|
          if @alias.save
            format.html { redirect_to @alias, notice: 'Alias was successfully created.' }
            format.json { render json: @alias, status: :created }
          else
            format.html { render action: "new" }
            format.json { render json: @alias.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /aliases/1
      # PUT /aliases/1.json
      def update
        @alias = Alias.find(params[:id])

        respond_to do |format|
          if @alias.update_attributes(alias_params)
            format.html { redirect_to @alias, notice: 'Alias was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @alias.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /aliases/1
      # DELETE /aliases/1.json
      def destroy
        @alias = Alias.find(params[:id])
        @alias.destroy

        respond_to do |format|
          format.html { redirect_to aliases_url }
          format.json { head :no_content }
        end
      end


      private

      def alias_params
        params.require(:alias).permit(:name, :emailaddress, :description)
      end
    end
  end
end
