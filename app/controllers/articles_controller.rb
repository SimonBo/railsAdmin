class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :check_admin, except: [:show, :index]
  

  # GET /articles
  # GET /articles.json
  def index
    
    @search = Article.search(params[:q])
    @articles = @search.result
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    # rand_record = Article.order("RANDOM()").first(3)
    # @rand_record1 = rand_record[0]
    # @rand_record2 = rand_record[1]
    # @rand_record3 = rand_record[2]
    @most_popular = Article.most_popular
    @most_discussed = Article.most_comments
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article  = Article.find(params[:id])
    @pictures = @article.pictures
    @article.update_column(:visits, @article.visits + 1)
  end

  # GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find_by_id(params[:id])
    @categories = Category.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save

        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @article.pictures.create(image: image)
          }
        end
          format.html { redirect_to @article, notice: "Article was successfully created." }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = Article.find_by_id(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article was updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

 

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :excerpt, :author_id, :cover_photo, :photo, :pictures, :images, :category_ids =>[])
    end

 

    def check_admin
      unless current_user && current_user.admin? || current_user.author?
        flash[:notice] = "You are not an admin/author"
        redirect_to articles_path unless current_user && current_user.admin? || current_user.author?
      end
    end
   
    # def check_author
    #   unless current_user && current_user.author?
    #     flash[:notice] = "You are not an author"
    #     redirect_to articles_path unless current_user && current_user.author?
    #   end
    # end 
end
