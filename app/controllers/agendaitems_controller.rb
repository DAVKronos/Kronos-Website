class AgendaitemsController < ApplicationController
  load_and_authorize_resource
  
  def index
#    @agendaitems = Agendaitem.where("date >= ?", Time.now).paginate(:page => params[:page], :order => 'date ASC', :per_page => 10)
    @agendaitems = Agendaitem.where("date >= ?", Time.now.midnight).order("date ASC");
  	@dates = Hash.new;
  	@cals = Hash.new;
    @agendaitems.each do |d|
      if !d.agendaitemtype.is_match
  			if @dates[d.date.strftime("%F")]
  				@dates[d.date.strftime("%F")]["htmlclass"] = "activity";
  				@dates[d.date.strftime("%F")]["tooltips"] += "";
  			else
  				@dates[d.date.strftime("%F")] = {"htmlclass" => "activity", "tooltips" => ""};
  			end
  		else
  			if !@dates[d.date.strftime("%F")]
  				@dates[d.date.strftime("%F")] = {"htmlclass" => "match", "tooltips" => ""};
  			else
  				@dates[d.date.strftime("%F")]["tooltips"] += "";
  			end
  		end
  		@dates[d.date.strftime("%F")]["tooltips"] += d.name + "";
  		@cals[d.date.strftime("%Y-%m")] = d.date;
  	end
  	@agendaitems = @agendaitems.take(2);

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: Agendaitem.search(params[:q],10)}
    end
  end
  
  def perdag
    days = Agendaitem.where("date >= ?", Time.now.midnight).order("date ASC");
	@dates = Hash.new;
	@cals = Hash.new;
    days.each do |d|
	    if !d.agendaitemtype.is_match
			if @dates[d.date.strftime("%F")]
				@dates[d.date.strftime("%F")]["htmlclass"] = "activity";
				@dates[d.date.strftime("%F")]["tooltips"] += "
";
			else
				@dates[d.date.strftime("%F")] = {"htmlclass" => "activity", "tooltips" => ""};
			end
		else
			if !@dates[d.date.strftime("%F")]
				@dates[d.date.strftime("%F")] = {"htmlclass" => "match", "tooltips" => ""};
			else
				@dates[d.date.strftime("%F")]["tooltips"] += "
";
			end
		end
		@dates[d.date.strftime("%F")]["tooltips"] += d.name + "";
		@cals[d.date.strftime("%Y-%m")] = d.date;
	end
	@agendaitems = Agendaitem.where(:date => (Time.parse(params[:day]).midnight)..(Time.parse(params[:day]).midnight + 1.day)).order("date ASC");
	render :action => "index"
  end
  
  def wedstrijden
    @agendaitems = Agendaitem.joins(:agendaitemtype).where(:agendaitemtypes => {:is_match => true}).where("date >= ?", Time.now).paginate(:page => params[:page], :per_page => 10)
    render :action => "archief"    
  end
  
  def archief
    @agendaitems = Agendaitem.paginate(:page => params[:page], :order => 'date DESC', :per_page => 10)
  end

  def month
    if (params[:year].nil? || params[:month].nil?) then
      date = Date.today
    else
      begin
        date = DateTime.new(params[:year].to_i,params[:month].to_i)
      rescue ArgumentError
        date = Date.today
        redirect_to '/agenda/'
      end
    end
    
    earliest = Agendaitem.first(:order => 'date asc').date.to_date
    latest = Agendaitem.last(:order=>'date asc').date.to_date
    range = Array.new
 
    (earliest.year..latest.year).each do |y|
      mo_start = (earliest.year == y) ? earliest.month : 1
      mo_end = (latest.year == y) ? latest.month : 12
      (mo_start..mo_end).each do |m|  
        range << [y,m]         
      end
    end 
    
    before, after = range.partition {|e| (Date.new(e.first,e.second) < date.beginning_of_month ) }
    after = after.drop(1)
    
    @agendaitems = Agendaitem.where(:date => date.beginning_of_month..date.next_month)
    @current = date
    @years = range.map{|e| e.first}.uniq

    @past = before.map{|e| Date.new(e.first,e.second)}
    @present = after.map{|e| Date.new(e.first,e.second)}
  end

  def new
    @agendaitem = Agendaitem.new
    @agendaitem.date = Time.now
    @agendaitem.subscriptiondeadline = Time.now
    @commissions = current_user.admin? ? Commission.all : current_user.commissions
    @agendaitemtypes = Agendaitemtype.all
#    @agendaitemtypes.each do |item|
#      @selects[item.id] = options_for_select(item.eventtypes.collect { |p| [p.name, p.id] })
#    end
  end
  
  def show
    @agendaitem = Agendaitem.find(params[:id])
    @comments = @agendaitem.comments
    @comment = @agendaitem.comments.build
    
    if current_user
      @agendaitem.subscriptions.each do |subscr|
        if subscr.user == current_user
          @subscriptionbestaand = subscr
        end
      end
      if (defined?(@subscriptionbestaand)).nil?
        @subscription = Subscription.new
        @subscription.name = current_user.name
        @subscription.agendaitem = @agendaitem
      end
    end
  end

  def create
    @agendaitem = Agendaitem.new(params[:agendaitem])
	@agendaitem.user = current_user
	
    respond_to do |format|
      if @agendaitem.save
        format.html { redirect_to @agendaitem, notice: 'Agendaitem was successfully created.' }
        format.json { render json: @agendaitem, status: :created, location: @agendaitem }
      else
        format.html { render action: "index" }
        format.json { render json: @agendaitem.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new_result
    @agendaitem = Agendaitem.new
	@agendaitemtypes = Agendaitemtype.all
    @agendaitem.date = Time.now
  end
  
  def create_result
    @agendaitem = Agendaitem.new(params[:agendaitem])
	@agendaitem.user = current_user
	
    respond_to do |format|
      if @agendaitem.save
        format.html { redirect_to agendaitem_events_path(@agendaitem), notice: 'Agendaitem was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.destroy

    respond_to do |format|
      format.html { redirect_to agendaitems_path }
      format.json { head :ok }
    end
  end

  def edit
    @agendaitem = Agendaitem.find(params[:id])
    @commissions = current_user.admin? ? Commission.all : current_user.commissions
    @agendaitemtypes = Agendaitemtype.all
  end

  def update
    @agendaitem = Agendaitem.find(params[:id])
    @agendaitem.attributes = params[:agendaitem]
    @agendaitem.comments.each do |comment|
        comment.user = current_user if comment.new_record?
    end

    respond_to do |format|
      if @agendaitem.save
        format.html { if params[:action] == "edit"
                        redirect_to edit_agendaitem_path(@agendaitem), notice: 'Agendaitem was successfully updated.'
                      else
                        redirect_to @agendaitem
                      end
        }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @agendaitem.errors, status: :unprocessable_entity }
      end
    end
  end
  

end
