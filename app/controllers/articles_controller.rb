class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    # @search = Article.search do
    #   fulltext params[:search]
    #   with(:published_at).less_than(Time.zone.now)
    #   facet(:publish_month)
    #   with(:publish_month, params[:month]) if params[:month].present?
    # end
    # @articles = @search.results
  end


  # GET /articles/1
  # GET /articles/1.json
  def show
    @article  = Article.find(params[:id])
    @pictures = @article.pictures
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

  # def undo_link
  #   view_context.link_to("undo", revert_version_path(@article.versions.scoped.last), :method => :post)
  # end

  # def undo
  #   @post_version = PaperTrail::Version.find_by_id(params[:id])
   
  #   begin
  #     if @post_version.reify
  #       @post_version.reify.save
  #     else
  #       # For undoing the create action
  #       @post_version.item.destroy
  #     end
  #     flash[:success] = "Undid that! #{make_redo_link}"
  #   rescue
  #     flash[:alert] = "Failed undoing the action..."
  #   ensure
  #     redirect_to root_path
  #   end
  # end

  # def history
  #   @versions = PaperTrail::Version.order('created_at DESC')
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # def make_redo_link
    #   params[:redo] == "true" ? link = "Undo that plz!" : link = "Redo that plz!"
    #   view_context.link_to link, undo_path(@article_version.next, redo: !params[:redo]), method: :post
    # end

    # def make_undo_link
    #   view_context.link_to 'Undo that plz!', undo_path(@article.versions.last), method: :post
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :excerpt, :author_id, :cover_photo, :photo, :pictures, :images, :category_ids =>[])
    end
end
