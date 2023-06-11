class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :post_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true
  
  def get_post_image(width, height)
    if post_image.attached?
      post_image.variant(resize_to_limit: [width, height]).processed
    end
  end
end
