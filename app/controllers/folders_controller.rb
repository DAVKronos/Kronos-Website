class FoldersController < ApplicationController
  load_and_authorize_resource
  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show
    @folder = Folder.find(params[:id])
  end
    
  def new
    @folder = Folder.new
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
