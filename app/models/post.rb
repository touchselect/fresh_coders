class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :post_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true
  
  scope :search, -> (search_param = nil){
    return if search_param.blank?
    joins("INNER JOIN action_text_rich_texts ON
          action_text_rich_texts.record_id = posts.id AND
          action_text_rich_texts.record_type = 'Post'")
    .where("action_text_rich_texts.body LIKE ? OR posts.title LIKE ? ", "%#{search_param}%", "%#{search_param}%")
  }
  
  def get_post_image(width, height)
    if post_image.attached?
      post_image.variant(resize_to_limit: [width, height]).processed
    end
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
