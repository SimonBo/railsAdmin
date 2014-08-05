class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @category = Category.new
    @articles = Article.all
  end

  # GET /articles/1/edit
  def edit
    @articles = Article.all
  end

  def create
    @category = Category.new(category_params)
    
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
 
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

   def destroy
    
    @category.destroy
    redirect_to article_path(@article)
  end
  private
    def category_params
      params.require(:category).permit(:name, :article_ids => [])
    end
end
