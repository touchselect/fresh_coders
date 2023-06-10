class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = currrent_user.id
    @post.save
    redirect_to posts_path
  end
  
  def index
    @posts = Post.all
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :post_image)
  end
end
