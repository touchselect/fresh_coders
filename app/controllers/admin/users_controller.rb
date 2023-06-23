class Admin::UsersController < ApplicationController

  def index
    @users = User.order(created_at: :desc)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  def drafts
    @user = User.find(params[:id])
    @draft_posts = Post.with_inactive(@user.id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
