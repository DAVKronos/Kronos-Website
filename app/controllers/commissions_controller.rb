class CommissionsController < Admin::ApplicationController
  load_and_authorize_resource
  
  def new
    @commission = Commission.new
  end
  
  def create
    @commission = Commission.new(commission_params)
    if @commission.save
      redirect_to @commission
    else
      render 'new'
    end
  end
  
  def show
    @commission = Commission.find_by_id(params[:id])
    @commission_memberships = Commission.find_by_id(params[:id]).commission_memberships

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commission.as_json(include: {commission_memberships: {include: {user: {only: :name}}}})}
    end
  end
  
  def index
    @commissions = Commission.order("name").all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commissions}
    end
  end
  
  def edit
    @commission = Commission.find_by_id(params[:id])
  end
  
  def update
    @commission = Commission.find_by_id(params[:id])
    if @commission.update_attributes(commission_params)
      flash[:success] = "Commission updated."
      redirect_to @commission
    else
      render 'edit'
    end
  end
  
  def destroy
     commission = Commission.find(params[:id])
      commission.destroy
      flash[:success] = "Commissie Verwijderd"
      redirect_to commissions_path
  end

  private

  def commission_params
    # TODO controller now permits all models attributes, try to be more specific
    params.require(:commission).permit!
  end
end