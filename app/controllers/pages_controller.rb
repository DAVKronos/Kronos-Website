class PagesController < ApplicationController
  load_and_authorize_resource
  def home
    @newsitems = Newsitem.where(:agreed => true).order('created_at DESC').limit(6)
    @agendaitems = Agendaitem.where("date >= ?", Time.now).order('date ASC').limit(10)
    
    @birthdays = User.where(:user_type_id => [1,2,8])
    @birthdays.keep_if {|bd| (bd.days_until_birthday.between?(0,14) || bd.days_until_birthday.between?(358,366))}
    @birthdays.sort_by{|e| e.days_until_birthday}
    
  end

  def titleshow
    @page = Page.find_by_pagetag(params[:pt])
    render 'show'
  end
  
  def show
    @page = Page.find(params[:id])
  end
    
  def test
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
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
      if @page.update_attributes(params[:page])
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
end
