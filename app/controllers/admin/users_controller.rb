class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.includes(:posts).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end
  
  def drafts
    @user = User.find(params[:id])
    @draft_posts = Post.with_inactive(@user.id).order(created_at: :desc).page(params[:page]).per(10)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
