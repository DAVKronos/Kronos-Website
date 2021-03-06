class PagesController < ApplicationController
  load_and_authorize_resource
  def home
    @newsitems = Newsitem.where(:agreed => true).order('created_at DESC').limit(6)
    training_types = Agendaitemtype.where('name like ?', '%Training%')
    @agendaitems = Agendaitem.where.not(agendaitemtype: training_types).where("date >= ?", Time.now).order('date ASC').limit(10)
    
    @birthdays = {}
    @birthdays['current_month'] = User.where( '(user_type_id not in (?)) AND
                               (extract(month from birthdate) = ? AND extract(day from birthdate) >= ?)
                              ',
                              [9], 
                              Date.today.strftime("%m"), Date.today.strftime("%d"))
                     .order(Arel.sql('extract(month from birthdate) ASC, extract(day from birthdate) ASC'))

    @birthdays['next_month'] = User.where( '(user_type_id not in (?)) AND
                               (extract(month from birthdate) = ? AND extract(day from birthdate) <= ?)
                              ',
                             [9],
                             Date.today.next_month.strftime("%m"), Date.today.next_month.strftime("%d"))
                     .order(Arel.sql('extract(month from birthdate) ASC, extract(day from birthdate) ASC'))
  end

  def titleshow
    @page = Page.find_by_pagetag(params[:pt])
    authorize! :show, @page
    if @page then render 'show' else page_not_found end
    end

  def index
    @pages = Page.order(pagetag: :asc)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @page = Page.find(params[:id])
  end
    
  def test
  end


  def game
	agendaitem = Agendaitem.find_by(name: 'Pilscie Games')
  @events = Event.where(agendaitem_id: agendaitem.try(:id))
	@results = Result.where(event_id: @events.first.try(:id))
  @results2 = Result.where(event_id: @events[1].try(:id))
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
        format.html { redirect_to '/'+@page.pagetag, notice: 'Page was successfully updated.' }
        format.json { head :ok }
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
    if(current_user && current_user.last_login_at)
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
