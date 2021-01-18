class ArticlesController < ApplicationController
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def show
    @article = Article.find(params[:id])
    @articlenew = Article.order("created_at DESC")
    @comments = @article.comments
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  
  def index
    @articles = Article.order("created_at DESC").paginate(page: params[:page], per_page: 5)
    
  end
  
  def new
      @article = Article.new
  end
  
  
  def edit
      @article = Article.find(params[:id])
  end
  
  def create
        @article = Article.new(params.require(:article).permit(:title, :description, :image, category_ids: []))
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article is successfully created"
            redirect_to @article
        else
            render 'new' 
        end
        
  end
  
  def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description, :image, category_ids: []))
            flash[:notice] = "Article is updated successfully."
            redirect_to @article
        else
            render 'edit'
        end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  
  private
  
  def require_same_user
    if current_user != Article.find(params[:id]).user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to Article.find(params[:id])
    end
  end
  
end