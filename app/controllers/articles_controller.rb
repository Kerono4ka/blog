class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :create, :show]

  skip_before_action :authorize, only: [:show]

  def index
    @articles = current_user.articles.includes(:user)

    if params.has_key? :search
      @search = params[:search]
      @articles = @articles.where("title like ?", "%#{@search}%")
    end

    @articles = @articles.order(created_at: :desc).page(params[:page])   
  end

  def show
    @article = Article.find(params[:id])
    @comment_page = params[:page]
    @comments = @article.comments.order(created_at: :desc).paginate(:page => @comment_page)
  end    

  def new
    @article = current_user.articles.build
  end

  def edit
  end

  def create
    @article = current_user.articles.create(article_params)

    if @article.valid?
      flash[:success] = "Article was successfully created!"
      redirect_to @article
    else  
      flash[:alert] = "Acticle wasn't created!"
      render 'new'      
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to @article
    else
      flash[:alert] = "Acticle wasn't updated!"
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article was successfully deleted!"
    else
      flash[:error] = "Something went wrong, the acticle wasn't deleted"
    end
    redirect_to articles_path
  end

  private
  def set_article
    @article = current_user.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :image)
  end
end
