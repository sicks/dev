class ArticlesController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Current.user.articles.new
  end

  def create
    @article = Current.user.articles.create!(article_params)

    redirect_to article_path(@article), notice: "Article Created!"
  end

  def show
    @article = Article.find(params[:id])
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
    params.require(:article).permit(:title, :markdown, :tag_list)
  end

  def set_article
    @article = Current.user.articles.find(params[:id])
  end
end
