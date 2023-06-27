class Admin::DraftsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_draft
  
  def show
  end

  def edit
  end
  
  def update
    if params[:post_button] == "true"
      @post.is_active = true
      @post.update(draft_post_params)
      redirect_to admin_post_path(@post.id)
      return
    end
    @post.update(draft_post_params)
    redirect_to admin_post_draft_path(post_id: @post.id)
  end

  def destroy
    user = @post.user
    @post.destroy
    redirect_to admin_user_drafts_path(user.id)
  end
  
  private
  
  def draft_post_params
    params.require(:post).permit(:title, :content, :post_image, :category_id)
  end
  
  def set_draft
    @post = Post.unscoped.includes(:category).where(is_active: false, id: params[:post_id]).first
  end

end
