class Admin::PostsController < ApplicationController
  
  def index
    @categories = Category.includes(:posts)
    if params[:query].present?
      @posts = Post.search(params[:query]).order(created_at: :desc)
      @query = params[:query]
    elsif params[:category_id]
      @category = Category.includes(:posts).find(params[:category_id])
      @posts = @category.posts
    else
      @posts = Post.order(created_at: :desc)
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
end
