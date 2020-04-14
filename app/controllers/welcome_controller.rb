class WelcomeController < ApplicationController
  skip_before_action :authorize

  def index
    if params.has_key? :search
      @search = params[:search]
      @articles = Article.where("title like ?", "%#{@search}%")
    else
      @articles = Article.all.order('created_at DESC').page(params[:page])
    end
  end

end
