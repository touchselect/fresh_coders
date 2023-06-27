class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
    @category = Category.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:draft_button] == "true"
      @post.is_active = false
    end
    @post.save
    redirect_to posts_path
  end

  def index
    @categories = Category.all
    if params[:query].present?
      @posts = Post.includes(:user, :comments).search(params[:query]).order(created_at: :desc).page(params[:page]).per(10)
      @query = params[:query]
    elsif params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.includes(:user, :comments).page(params[:page]).per(10)
    else
      @posts = Post.includes(:user, :comments).order(created_at: :desc).page(params[:page]).per(10)
    end
  end


  def show
    @post = Post.includes(comments: :user).find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:draft_button] == "true"
      @post.is_active = false
      @post.update(post_params)
      redirect_to post_draft_path(@post.id)
      return
    end
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :post_image, :category_id)
  end
end
