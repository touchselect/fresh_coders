class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
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
  
  def favorites
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts
  end
  
  def drafts
    @user = User.find(params[:id])
    @draft_posts = Post.with_inactive(@user.id)
  end
  
  def following
    @user = User.find(params[:id])
		@users = @user.following
  end

  def followed
    @user = User.find(params[:id])
		@users = @user.followers
  end
  
  def dummy
    redirect_to new_user_registration_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user)
    end
  end 
  
end
