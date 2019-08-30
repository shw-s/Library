class ArticlesController < ApplicationController
   before_action :authenticate_user!
   before_action :Article, only: [:show, :destroy, :edit, :update, :article_borrow_do, :article_list]
  
  def index
    # @articles = Article.all
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @article =Article.new
    @catalogs = Catalog.pluck(:name,:id)
    #@catalogs  = Catalog.select(:id,:name).collect { |catalog| [catalog.name , catalog.id]}
  end


  def create
    @catalog_id = params[:catalog_id]
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render'new'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def edit
    @catalogs = Catalog.pluck(:name,:id)
  end

  def update
    if@article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def article_list
    @user = User.find_by_id(current_user.id)
  end

  def article_borrow_do
    @user = User.find_by_id(current_user.name)
    borrow = Borrow.new(article_id:@article.id, article_name:@article.title, user_id:current_user.id ,user_name:current_user.name)
      if borrow.save   
        @article.update(number: @article.number-1 )
        if @article.save
          flash[:message] = "操作成功等待管理员审核"
          redirect_to borrows_path
        end
      end
  end

  def article_excel
    @catalog = Catalog.select(:id, :name)
    file = params[:excel].path
    file_name = params[:excel].original_filename.split(".")
    if file_name.last == 'xlsxs'
      xlsx = Roo::Spreadsheet.open(file)
      message = ""
      xlsx.sheet("Sheet1").each_with_index do |row,index|
        next if index == 0
        title = row[0]
        text =  row[1]
        serial = row[2]
        number = row[3]
        catalog =row[4] 
        unless catalog = Catalog.find_by(name: catalog)
          catalog = Catalog.create(name: row[4])
          catalog.save
        end     
        article = Article.new(title:title, text:text, serial:serial, number:number, catalog_id:catalog.id) 
        article.save
        message << "第"+"#{index+1}"+"行"+"保存失败，失败原因是:"+article.errors.full_messages.join(',') if !article.save
      end
      flash[:errors] = message 
    else
      flash[:errors] = "只能上传excel文件"
    end
      redirect_to articles_path
  end
  
  def excel_import
    s_region_code_id = params[:s_region_code_id]
    excel = params[:excel]
    filename = excel.original_filename
    Rails.logger.info "----------filename------#{filename}-------"
    names = filename.split(".")
    file_type = names[1]
    if file_type == 'xlsx'
      @excel_datas = Article.read_excel(excel)  #从excel读取信息
      @excel_datas.each do |e|
        e.push(s_region_code_id.to_i)
        e.push(region_name)
    end
      Article.save_excel(@excel_datas)  
      render json: {status: 200}
    end
  end

  private
    def article_params
      params.require(:article).permit(:id,:serial,:title,:text,:number,:img,:catalog_id, users_attributes: [ :id ,:name])
    end

    def Article
      @article = Article.find_by(id: params[:id])
    end
end
