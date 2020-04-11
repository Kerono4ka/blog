class WelcomeController < ApplicationController
  skip_before_action :authorize

  def index
    if params.has_key? :search
      @search = params[:search]
      @articles = Article.where("title like ?", "%#{@search}%")
    else
      @articles = Article.all.order('created_at DESC').page(params[:page])
      @custom_paginate_renderer = custom_paginate_renderer
    end
  end

end
