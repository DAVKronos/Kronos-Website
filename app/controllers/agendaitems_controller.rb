class AgendaitemsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    if params[:date].nil? || params[:date][:year].nil? || params[:date][:year].nil?
      date = Date.today
    else
      date = DateTime.new(params[:date][:year].to_i, params[:date][:month].to_i)
    end

    earliest = Agendaitem.first(order: 'date asc').date.to_date
    earliest = Date.new(1964, 1) if earliest.year < 1964

    latest = Agendaitem.last(order: 'date asc').date.to_date
    range = []

    (earliest.year..latest.year).each do |y|
      mo_start = (earliest.year == y) ? earliest.month : 1
      mo_end = (latest.year == y) ? latest.month : 12
      (mo_start..mo_end).each { |m| range << [y, m] }
    end

    before, after = range.partition do |e|
      Date.new(e.first, e.second) < date.beginning_of_month
    end

    after = after.drop(1)

    @agendaitems = Agendaitem.where(date: date.beginning_of_month..date.end_of_month)
    @agendaitems.order('date ASC')

    @date = date
    @years = range.map(&:first).uniq

    @past = before.map { |e| Date.new(e.first, e.second) }
    @present = after.map { |e| Date.new(e.first, e.second) }

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
    @agendaitem.subscriptions.each do |subscr|
      @subscriptionbestaand = subscr if subscr.user == current_user
    end
    return unless defined?(@subscriptionbestaand).nil?
    @subscription = Subscription.new(current_user.name, @agendaitem)
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
