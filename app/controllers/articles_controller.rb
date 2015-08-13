class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :add_comment]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.page(params[:page])
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
    @article = Article.new(article_params)

    respond_to do |format|
      @article.save
      format.js
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      @article.update_with_conflict_validation(article_params)
      format.js
    end
  end

  def add_comment
    @comment = @article.comments.build(comment_params)

    respond_to do |format|
      @comment.save
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
end
