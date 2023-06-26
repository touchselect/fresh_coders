class Public::CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to new_post_path
  end

  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
end
