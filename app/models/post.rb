class Post < ApplicationRecord
  has_many_attached :post_images
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category
  
  def get_post_image
    post_image
  end
end
