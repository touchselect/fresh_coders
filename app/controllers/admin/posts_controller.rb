class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.includes(:posts)
    if params[:query].present?
      @posts = Post.search(params[:query]).order(created_at: :desc).page(params[:page]).per(10)
      @query = params[:query]
    elsif params[:category_id]
      @category = Category.includes(:posts).find(params[:category_id])
      @posts = @category.posts.page(params[:page]).per(10)
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
end
