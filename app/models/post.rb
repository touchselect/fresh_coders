class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :post_image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true
  
  validates :title, presence: true
  
  default_scope { where(is_active: true) } 
  
  scope :search, -> (search_param = nil){
    return if search_param.blank?
    joins("INNER JOIN action_text_rich_texts ON
          action_text_rich_texts.record_id = posts.id AND
          action_text_rich_texts.record_type = 'Post'")
    .where("action_text_rich_texts.body LIKE ? OR posts.title LIKE ? ", "%#{search_param}%", "%#{search_param}%")
  }
  
  # def get_post_image(width, height)
  #   unless post_image.attached?
  #     file_path = Rails.root.join('app/assets/images/sample_post.jpg')
  #     post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   post_image.variant(resize_to_limit: [width, height]).processed
  # end
  
  def get_post_image(width, height)
    unless post_image.attached?
      image_dir = Rails.root.join('app/assets/images/posts/')
      image_files = Dir.glob(File.join(image_dir, '*'))
  
      if image_files.present?
        random_image_path = image_files.sample
        post_image.attach(io: File.open(random_image_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      else
        file_path = Rails.root.join('app/assets/images/sample_post.jpg')
        post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.with_inactive(user_id)
    unscoped.where(is_active: false, user_id: user_id)
  end
  

end
