class BorrowsController < ApplicationController
  before_action :authenticate_user!
  before_action :Borrow, only: [:show, :destroy, :edit, :update, :examine, :examine_do, :return_do, :return, :return_list, :return_list_do]
  def index
    if current_user.role_ids.include?(1)
      @borrows = Borrow.all
    else
      @borrows = Borrow.where(user_id: current_user.id)
    end
  end

  def new
    @borrow = Borrow.new
  end
  
  def show
  end

  def edit
  end

  def update
    if @borrow.update(borrow_params) 
      redirect_to borrows_path
    else
      render 'edit'
    end
  end

  def destroy
    @borrow.destroy  
    redirect_to borrows_path
  end

  def examine
    @user = User.find_by_id(current_user.id)
  end

  def return
    @user = User.find_by_id(current_user.id)
  end

  def return_list
    @user = User.find_by_id(current_user.id)
  end

  def return_do
    @article = Article.find_by_id(@borrow.article_id)
    @borrow.update(reason:'未审核')
    flash[:message] = "操作成功等待管理员审核"
    redirect_to borrows_path
  end

  def return_list_do
    @user = User.find_by_id(current_user.id)
    @article = Article.find_by_id(@borrow.article_id)
    @borrow.update(reason:params[:reason]) 
    if (@borrow.reason ==  '已归还' )
      @article.update(number:@article.number+1)
      redirect_to borrows_path
    else
      redirect_to borrows_path
    end
  end

  def examine_do
    @user = User.find_by_id(current_user.id)
    @article = Article.find_by_id(@borrow.article_id)
    @borrow.update(auditor_id:current_user.id, auditor_name:current_user.name, state:params[:state]) 
    if (@borrow.state ==  '通过' )
      redirect_to borrows_path
    else
      @article.update(number:@article.number+1)
      redirect_to borrows_path
    end
  end
  
  private
    def borrow_params
      params.require(:borrow).permit(:article_id, :state, :reason, :auditor_id ,:user_id ,:user_name ,:auditor_name)
    end

    def Borrow
       @borrow = Borrow.find_by(id: params[:id])
    end
end
