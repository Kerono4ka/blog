class CommentsController < ApplicationController
  before_action :set_article
  before_action :find_commentable
  before_action :find_reply_type, only: [:new, :create]

  def new
    @comment = @commentable.comments.build(user_id: current_user.id) 

    my_love = "something"
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @commentable.comments.create(comment_params)

    if @comment.valid?
      flash.now[:success] = "Your comment was successfully created!"
      respond_to do |format|
      # format.html { redirect_to article_path(@article) }
        format.js
      end  
    else
      flash.now[:alert] = "Comment wasn't created!"
      render 'new'      
    end  
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    if @commentable.article_commentable_type?
      @comment_page = params[:page]
      @comments = @article.comments.order(created_at: :desc).paginate(:page => @comment_page)
      @custom_paginate_renderer = custom_paginate_renderer
    end

    if @comment.destroy
      flash[:success] = "Comment was successfully deleted!"
    else
      flash[:error] = "Something went wrong, the comment wasn't deleted"
    end
    respond_to do |format|
      format.js
      # format.html { redirect_to article_path(@article) }
    end
  end


  private
  def find_reply_type
    @reply_type = params[:comment_id] ? 'comment-reply' : 'article-reply'
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def find_commentable
      @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
