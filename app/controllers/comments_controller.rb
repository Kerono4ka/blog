class CommentsController < ApplicationController
  before_action :set_article
  before_action :find_commentable

  def new
    @comment = @commentable.comments.build(user_id: current_user.id)
  end

  def create
    @comment = @commentable.comments.create(comment_params)

    if @comment.save
      redirect_to article_path(@article)
    else  
      render 'new'      
    end  
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    redirect_to article_path(@article)
  end


  private
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
