class CategoriesController < ApplicationController
  def show
  end

  def create
    @article = Article.find(params[:article_id])
    @category = @article.categories.create(category_params)
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to @article, notice: 'Category added' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { redirect_to @article, notice: 'Category not added'}
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
 
   def destroy
    @article = Article.find(params[:article_id])
    @category = @article.categories.find(params[:id])
    @category.destroy
    redirect_to article_path(@article)
  end
  private
    def category_params
      params.require(:category).permit(:name)
    end
end
