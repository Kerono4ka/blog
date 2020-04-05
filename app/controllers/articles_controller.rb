class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "bla", password: "bla",
  except: [:index, :show]

  before_action :set_article, except: [:index, :new, :create]

  def index
    if params.has_key? :search
      @search = params[:search]
      @articles = Article.where("title like ?", "%#{@search}%")
    else
      @articles = Article.all
    end
    
  end

  def show
    # @article = Article.find(params[:id])
  end    

  def new
    @article = Article.new
  end

  def edit
    # @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else  
      render 'new'      
    end
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :image)
  end
end
