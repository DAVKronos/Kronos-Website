module Api
  module V1
    class PagesController < Api::V1::ApplicationController
      load_and_authorize_resource

      def home
        @newsitems = Newsitem.where(:agreed => true).order('created_at DESC').limit(6)
        @agendaitems = Agendaitem.where("date >= ?", Time.now).order('date ASC').limit(10)

        @birthdays = {}
        @birthdays['current_month'] = User.where('(user_type_id not in (?)) AND
                               (extract(month from birthdate) = ? AND extract(day from birthdate) >= ?)
                              ',
                                                 [9],
                                                 Date.today.strftime("%m"), Date.today.strftime("%d"))
                                          .order(Arel.sql('extract(month from birthdate) ASC, extract(day from birthdate) ASC'))

        @birthdays['next_month'] = User.where('(user_type_id not in (?)) AND
                               (extract(month from birthdate) = ? AND extract(day from birthdate) <= ?)
                              ',
                                              [9],
                                              Date.today.next_month.strftime("%m"), Date.today.next_month.strftime("%d"))
                                       .order(Arel.sql('extract(month from birthdate) ASC, extract(day from birthdate) ASC'))
      end

      def titleshow
        @page = Page.find_by_pagetag(params[:pt])
        authorize! :show, @page
        if @page then
          render 'show'
        else
          page_not_found
        end
      end

      def index
        if params[:agreed].present?
          @pages = Page.where(:agreed => true).order(pagetag: :asc)
        else
          @pages = Page.order(pagetag: :asc)
        end

        if params[:order_by].present?
          @pages = @pages.o
        end

        if params[:limit].present?
          @pages = @pages.limit(params[:limit])
        end

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @pages }
        end
      end

      def show
        @page = Page.find(params[:id])

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @page }
        end
      end

      def test
      end


      def game
        agendaitem = Agendaitem.find_by(name: 'Pilscie Games')
        event = Event.find_by(agendaitem_id: agendaitem.id)
        @results = Result.where(event_id: event.id)
        render 'game'
      end

      def new
        @page = Page.new
      end

      def create
        @page = Page.new(page_params)
        if @page.save
          redirect_to @page
        else
          render 'new'
        end
      end

      def edit
        @page = Page.find(params[:id])
      end

      def update
        @page = Page.find(params[:id])

        respond_to do |format|
          if @page.update_attributes(page_params)
            format.html { redirect_to '/' + @page.pagetag, notice: 'Page was successfully updated.' }
            format.json { render json: @page  }
          else
            format.html { render action: "edit" }
            format.json { render json: @page.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        page = Page.find(params[:id])
        page.destroy
        flash[:success] = "Pagina verwijderd"
        redirect_to :root
      end

      def nieuw
        if (current_user && current_user.last_login_at)
          @users = User.where(:created_at => (current_user.last_login_at)..(Time.now)).paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 10)
          @chatmessages = Chatmessage.where(:created_at => (current_user.last_login_at)..(Time.now)).paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 10)

          respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @chatmessages }
          end
        else
          redirect_to :root
        end
      end

      def hide_banner
        cookies['banner'] = 'false'
        render :text => 'success'
      end

      private

      def page_not_found
        raise ActionController::RoutingError.new('Page Not Found')
      end

      def page_params
        # TODO controller now permits all models attributes, try to be more specific
        params.require(:page).permit!
      end

    end
  end
end