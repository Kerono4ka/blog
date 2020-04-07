class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :create, :show]

  skip_before_action :authorize, only: [:show]

  def index
    if params.has_key? :search
      @search = params[:search]
      @articles = current_user.articles.where("title like ?", "%#{@search}%")
    else
      @articles = current_user.articles
    end   
  end

  def show
    @article = Article.find(params[:id])
  end    

  def new
    @article = current_user.articles.build
  end

  def edit
  end

  def create
    @article = current_user.articles.create(article_params)

    if @article.save
      redirect_to @article
    else  
      render 'new'      
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Successfully deleted!"
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
