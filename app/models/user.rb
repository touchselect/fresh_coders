class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  
  has_many :active_follows, class_name: 'Follow', foreign_key: 'active_follow_id', dependent: :destroy
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'passive_follow_id', dependent: :destroy

  has_many :following, through: :active_follows, source: :passive_followed
  has_many :followers, through: :passive_follows, source: :active_follower
  
  has_one_attached :user_image
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def follow(user)
    active_follows.create(passive_followed: user)
  end
  
  def unfollow(user)
    active_follows.find_by(passive_followed: user).destroy
  end

  def following?(user)
    following.include?(user)
  end
  
  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/sample_user.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
