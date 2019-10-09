class FoldersController < ApplicationController
  load_and_authorize_resource
  def index
    @folders = Folder.where(folder_id: [nil, ""])
    @kms = Kronometer.where(folder_id: [nil, ""])
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @folder = Folder.find(params[:id])
    @folders = Folder.where(folder_id: params[:id])
	@kms = Kronometer.where(folder_id: params[:id])
  end
    
  def new
    @folder = Folder.new
    @folders = Folder.all
  end
  
  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      redirect_to @folder
    else
      render 'new'
    end
  end
  
  def edit
    @folder = Folder.find(params[:id])
  end
  
  def destroy
    folder = Folder.find(params[:id])
    folder.destroy
    flash[:success] = "Pagina verwijderd"
    redirect_to :root
  end
  
  def folder_params
    # TODO controller now permits all models attributes, try to be more specific
    params.require(:folder).permit!
  end
end
