class ResultsController < ApplicationController
  load_and_authorize_resource

  def index
    if date_params_set?
      @date = Date.new(params[:date][:year].to_i,
                       params[:date][:month].to_i)
    else
      @date = Date.today
    end

    @agendaitems = Agendaitem.joins("LEFT OUTER JOIN events ON events.agendaitem_id = agendaitems.id")
                       .joins("LEFT OUTER JOIN results ON results.event_id = events.id")
                       .where(:date => @date.beginning_of_month..@date.end_of_month)
                       .where("results.id IS NOT NULL")
                       .group('agendaitems.id')
                       .order("date ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agendaitems.map{|agendaitem| agendaitem.as_json(include: {subscriptions: {only: :id}})} }
    end
  end

  def records
    index

    if params[:sex] === "male" and params[:loc] === "out"
      render 'results/male-out'
    elsif params[:sex] === "female" and params[:loc] === "out"
      render 'results/female-out'
    elsif params[:sex] === "male" and params[:loc] === "in"
      render 'results/male-in'
    elsif params[:sex] === "female" and params[:loc] === "in"
      render 'results/female-in'
    end
  end

  def new
    @agendaitems = Agendaitem.joins(:agendaitemtype).where(:agendaitemtypes => {:is_match => true}).order('date DESC')
  end

  def create
    if (params[:result][:event_id].present?)
      event = Event.find(params[:result][:event_id])
      result = event.results.build(result_params)
      result.save
      if request.xhr?
        render 'results/_show', :layout => false, :locals => {:event => result.event}
      else
        redirect_to agendaitem_events_path(event.agendaitem)
      end
    else
      require 'json'
      agendaitem = Agendaitem.find_by(name: 'Pilscie Games')
      event = Event.find_by(agendaitem_id: agendaitem.try(:id))
      Result.create(result: params[:result][:result], username: params[:result][:username], event_id: params[:result][:event_id])
      redirect_to game_path
    end
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    respond_to do |format|
      format.html { redirect_to agendaitem_events_path(@result.event.agendaitem) }
      format.json {
        render :json => true
      }
    end
  end

  def recalculate
    @result = Result.find(params[:id])
    @result.calculated = nil
    @result.calculatedResult
    respond_to do |format|
      format.html { redirect_to agendaitem_events_path(@result.event.agendaitem) }
      format.json {
        render :json => true
      }
    end
  end

  private

  def result_params
    # TODO controller now permits all models attributes, try to be more specific
    params.require(:result).permit!
  end

  def date_params_set?
    return params[:date].present? && params[:date][:year].present? && params[:date][:month].present?
  end

end
