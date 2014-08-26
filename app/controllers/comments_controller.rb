class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    # redirect_to article_path(@article)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:user_id, :content, :current_user)
    end
end