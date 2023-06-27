class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :favorites, :following, :followed]

  def show
    @user = User.includes(:posts).find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def drafts
    @user = User.find(params[:id])
    @draft_posts = Post.with_inactive(@user.id).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def following
    @user = User.find(params[:id])
		@users = @user.following.order(created_at: :desc).page(params[:page]).per(12)
  end

  def followed
    @user = User.find(params[:id])
		@users = @user.followers.order(created_at: :desc).page(params[:page]).per(12)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
  
end
