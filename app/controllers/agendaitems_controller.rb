class AgendaitemsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    if params[:date] && params[:date][:year] && params[:date][:year]
      @date = DateTime.new(params[:date][:year].to_i, params[:date][:month].to_i)
    else
      @date = Date.today
    end

    @agendaitems = Agendaitem.where(date: @date.beginning_of_month..@date.end_of_month)
    @agendaitems.order('date ASC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: Agendaitem.search(params[:q], 10) }
    end
  end

  def wedstrijden
    @agendaitems = Agendaitem.joins(:agendaitemtype)
    @agendaitems.where(agendaitemtypes: { is_match: true })
    @agendaitems.where('date >= ?', Time.now)
    @agendaitems.paginate(page: params[:page], per_page: 10)
    render action: 'archief'
  end

  def new
    @agendaitem = Agendaitem.new
    @agendaitem.date = Time.now
    @agendaitem.subscriptiondeadline = Time.now
    @commissions = current_user.commissions
    @commissions = Commission.all if current_user.admin?
  end

  def show
    @agendaitem = Agendaitem.find(params[:id])
    return unless current_user
    @subscription = Subscription.where(agendaitem_id: @agendaitem.id, user_id:current_user.id).first
    return if @subscription
    @subscription = Subscription.new(user: current_user, agendaitem: @agendaitem,name:current_user.name)
  end

  def create
    @agendaitem = Agendaitem.new(params[:agendaitem])
    @agendaitem.user = current_user
    flash[:notice] = 'Agendaitem was successfully created.' if @agendaitem.save
    respond_with(@agendaitem)
  end

  def new_result
    @agendaitem = Agendaitem.new
    @agendaitem.date = Time.now
    @agendaitemtypes = Agendaitemtype.all
  end

  def create_result
    @agendaitem = Agendaitem.new(params[:agendaitem])
    @agendaitem.user = current_user
    flash[:notice] = 'Agendaitem was successfully created.' if @agendaitem.save
    respond_with(@agendaitem)
  end

  def destroy
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.destroy
    flash[:notice] = 'Successfully destroyed agendaitem.'
    respond_with(@agendaitem)
  end

  def edit
    @agendaitem = Agendaitem.find(params[:id])
    @commissions = current_user.commissions
    @commissions = Commission.all if current_user.admin?
    @agendaitemtypes = Agendaitemtype.all
  end

  def update
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.attributes = params[:agendaitem]
    @agendaitem.comments.each do |comment|
      comment.user = current_user if comment.new_record?
    end
    flash[:notice] = 'Agendaitem was successfully updated.' if @agendaitem.save
    respond_with(@agendaitem)
  end
end
