class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :add_comment]

  # GET /articles
  # GET /articles.json
  def index
    @article_filter = ArticleFilter.new(article_filter_params)
    @articles = Article.search(@article_filter).includes(:category).page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def top_ten
    @articles = Article.top_ten.includes(:category)

    respond_to do |format|
      format.html
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.create(article_params)

    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article.update_with_conflict_validation(article_params)

    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @comment = @article.comments.create(comment_params)

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :author, :category_id, :text, :lock_version).merge({:ip => request.remote_ip})
    end

    def comment_params
      params.require(:comment).permit(:author, :text, :rating)
    end

    def article_filter_params
      params.require(:article_filter).permit(
          :title,
          :author,
          { :category_ids => [] },
          :rating_from,
          :rating_to,
          :comments_count_from,
          :comments_count_to,
          :order_column,
          :direction
      ) if params[:article_filter]
    end
end
