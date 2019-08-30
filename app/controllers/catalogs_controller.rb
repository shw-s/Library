class CatalogsController < ApplicationController
  before_action :authenticate_user!
  before_action :Catalog, only: [:show, :destroy, :edit, :update, :new ]
  def index
    @catalogs = Catalog.all
  end

  def show
  end

  def new
    @catalog = Catalog.new
    @catalogs= Catalog.roots.pluck(:name,:id)
  end

  def create
    @catalog = Catalog.new(catalog_params)
    if @catalog.save
      redirect_to catalogs_path
    else
      render'new'
    end
  end

  def edit
    @catalogs = Catalog.roots.pluck(:name,:id)

  end

  def update
    @catalog = Catalog.find(params[:id])
    if @catalog.update(catalog_params) 
      redirect_to catalogs_path
    else
      render 'edit'
    end
  end

  def catalogs_view
    
  end

  def destroy
    @catalog.destroy  
    redirect_to catalogs_path
  end

  private
    def catalog_params
      params.require(:catalog).permit(:name ,:parent_id)
    end

    def Catalog
       @catalog = Catalog.find_by(id: params[:id])
    end
end
