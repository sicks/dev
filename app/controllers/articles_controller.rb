class ArticlesController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_article, only: %i[edit update destroy]
  around_action :set_time_zone, only: %i[create edit update]

  def index
    @tags = params.has_key?(:tags) ? params[:tags].split("/").map { |tag| CGI.unescape(tag) } : []
    @articles = Article.order(published_at: :desc, created_at: :desc)
    @articles = @articles.for_host(Current.host) unless authenticated?
    @articles = @articles.published unless authenticated?
    @articles = @articles.with_tags(@tags) if @tags.any?
    @articles = @articles.page(params[:page])
  end

  def new
    @article = Current.user.articles.new
  end

  def create
    @article = Current.user.articles.create!(article_params)

    redirect_to article_path(@article), notice: "Article Created!"
  end

  def show
    @article = Article.friendly.find(params[:id])
  end

  def edit
  end

  def update
    @article.update!(article_params)

    redirect_to article_path(@article), notice: "Article Updated!"
  end

  def destroy
    @article.destroy!

    redirect_to articles_path, notice: "Article Deleted!"
  end

  private

  def article_params
    params.require(:article).permit(:title, :markdown, :tag_list, :published_at, veneer_ids: [])
  end

  def set_article
    @article = Current.user.articles.friendly.find(params[:id])
  end

  def set_time_zone(&block)
    Time.use_zone("Pacific Time (US & Canada)", &block)
  end
end
