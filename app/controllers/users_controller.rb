class UsersController < ApplicationController
  before_action :User, only: [:show, :destroy, :edit, :update, :role_assignment, :role_save]
  def index
    @users =User.all 
  end

  def show
  end

  def new
    @user =User.new
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def update
    if@user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user =User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render "new"
    end
  end

  def role_assignment
    @roles = Role.select(:id,:name)
  end

  def  role_save
    # @role_id  将user_role中的id 转换成 int 赋值@suer.role_ids
    # params[:role_ids].map{|role_id| role_id.to_i}
    # 缩写 params[:role_ids].map(&:to_i)
    @user.role_ids = params[:role_ids].map(&:to_i)
    # 在role_assignment 页面增加的role_ids 通过循环依次提取 
    # 转换类型 赋值到 role_user 的关联表中
    # 只要关联关系存在 修改传输过来的 role_ids 即可 自动进行修改 数组赋值传到role_user表中
  

    error_message = "角色分配失败"
    params[:role_ids].each do |role|
      user_id = @user.id
      role_id = role
      user_role = UserRole.new(user_id:user_id, role_id:role_id)
    end
      redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:id,:name, roles_attributes: [ :id, :name])
    end

    def User
      @user= User.find_by(id: params[:id])
    end
end
