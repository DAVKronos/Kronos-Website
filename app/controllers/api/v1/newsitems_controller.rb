module Api
  module V1
    class NewsitemsController < ApplicationController
      load_and_authorize_resource
      # GET /newsitems
      # GET /newsitems.json
      def index
        @newsitems = Newsitem.where(:agreed => true).order('created_at desc').paginate(:page => params[:page], :per_page => 10)
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @newsitems.map { |newsitem| newsitem.as_json(include: {user: {only: :name}}, methods: [:articlephoto_url_normal, :articlephoto_url_carrousel]) } }

        end
      end

      def agree
        @newsitems = Newsitem.where(:agreed => false)

        respond_to do |format|
          format.html # agree.html.erb
          format.json { render json: @newsitems.map { |newsitem| newsitem.as_json(include: {user: {only: :name}}, methods: [:articlephoto_url_normal, :articlephoto_url_carrousel]) } }
        end
      end

      def agreed
        @newsitem = Newsitem.find(params[:id])

        @newsitem.agreed = true
        @newsitem.agreed_by = current_user.id

        respond_to do |format|
          if @newsitem.update_attributes(params.permit(:id))
            format.html { redirect_to :controller => "newsitems", :action => "agree", notice: 'Newsitem was successfully updated.' }
            format.json { head :ok }
          end
        end
      end

      # GET /newsitems/1
      # GET /newsitems/1.json
      def show
        @newsitem = Newsitem.find(params[:id])

        @comment = Comment.new(:commentable_id => params[:id], :commentable_type => Newsitem)

        if current_user
          @comment.user = current_user
        end

        respond_to do |format|
          format.html # show.html.erb
          format.json { render :json => @newsitem.as_json(include: {user: {only: :name}}, methods: [:articlephoto_url_normal, :articlephoto_url_carrousel]) }
        end
      end

      # GET /newsitems/new
      # GET /newsitems/new.json
      def new
        @newsitem = Newsitem.new

        @newsitem = current_user.newsitems.build()

        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @newsitem }
        end
      end

      # GET /newsitems/1/edit
      def edit
        @newsitem = Newsitem.find(params[:id])
      end

      # POST /newsitems
      # POST /newsitems.json
      def create
        @newsitem = current_user.newsitems.build(newsitem_params)
        @newsitem.agreed = false

        respond_to do |format|
          if @newsitem.save
            format.html { redirect_to @newsitem, notice: 'Newsitem was successfully created. Please wait for the moderators to agree on your item' }
            format.json { render json: @newsitem, status: :created}
          else
            format.html { render action: "new" }
            format.json { render json: @newsitem.errors, status: :unprocessable_entity }
          end
        end
      end

      # PUT /newsitems/1
      # PUT /newsitems/1.json
      def update
        @newsitem = Newsitem.find(params[:id])

        respond_to do |format|
          if @newsitem.update_attributes(newsitem_params)
            format.html { redirect_to @newsitem, notice: 'Newsitem was successfully updated.' }
            format.json { render json: @newsitem }
          else
            format.html { render action: "edit" }
            format.json { render json: @newsitem.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /newsitems/1
      # DELETE /newsitems/1.json
      def destroy
        @newsitem = Newsitem.find(params[:id])
        @newsitem.destroy

        respond_to do |format|
          format.html { redirect_to newsitems_url }
          format.json { head :ok }
        end
      end

      private

      def newsitem_params
        # TODO controller now permits all models attributes, try to be more specific
        params.require(:newsitem).permit!
      end
    end
  end
end