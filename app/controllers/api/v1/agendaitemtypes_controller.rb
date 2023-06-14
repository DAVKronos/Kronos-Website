module Api
  module V1
    class AgendaitemtypesController < Api::V1::ApplicationController
      load_and_authorize_resource
      # GET /agendaitemtypes
      # GET /agendaitemtypes.json
      def index
        @agendaitemtypes = Agendaitemtype.all

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @agendaitemtypes }
        end
      end

      # GET /agendaitemtypes/1
      # GET /agendaitemtypes/1.json
      def show
        @agendaitemtype = Agendaitemtype.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @agendaitemtype }
        end
      end

      # GET /agendaitemtypes/new
      # GET /agendaitemtypes/new.json
      def new
        @agendaitemtype = Agendaitemtype.new

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @agendaitemtype }
        end
      end

      # GET /agendaitemtypes/1/edit
      def edit
        @agendaitemtype = Agendaitemtype.find(params[:id])
      end

      # POST /agendaitemtypes
      # POST /agendaitemtypes.json
      def create
        @agendaitemtype = Agendaitemtype.new(agendaitemtype_params)

        respond_to do |format|
          if @agendaitemtype.save
            format.html { redirect_to @agendaitemtype, notice: 'Agendaitemtype was successfully created.' }
            format.json { render json: @agendaitemtype, status: :created }
          else
            format.html { render action: "new" }
            format.json { render json: @agendaitemtype.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /agendaitemtypes/1
      # PUT /agendaitemtypes/1.json
      def update
        @agendaitemtype = Agendaitemtype.find(params[:id])

        respond_to do |format|
          if @agendaitemtype.update(agendaitemtype_params)
            format.html { redirect_to @agendaitemtype, notice: 'Agendaitemtype was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @agendaitemtype.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /agendaitemtypes/1
      # DELETE /agendaitemtypes/1.json
      def destroy
        @agendaitemtype = Agendaitemtype.find(params[:id])
        @agendaitemtype.destroy

        respond_to do |format|
          format.html { redirect_to agendaitemtypes_url }
          format.json { head :no_content }
        end
      end

      private

      def agendaitemtype_params
        # TODO controller now permits all models attributes, try to be more specific
        params.require(:agendaitemtype).permit!
      end
    end
  end
end
