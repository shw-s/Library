class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :Role, only: [:show, :destroy, :edit, :update, ]
  def index
    @roles = Role.all
  end

  def show
  end

  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(role_params)
    if@role.save
      redirect_to @role
    else 
      render'new'
    end
  end

  def edit
  end

  def destroy
    @role.destroy
    redirect_to roles_path
  end

  def update
    if@role.update(role_params)
      redirect_to @role
    else
      render 'edit'
    end
  end

 


  private
    def role_params
      params.require(:role).permit(:name, :desc, :kind)
    end

    def Role
      @role = Role.find_by(id: params[:id])  
    end
end
