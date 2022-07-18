class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts
  has_many :comments
  has_many :favorites

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #退会したユーザーの投稿を全て削除する
  def update_status_destroy
    if update(user_status: false)
      posts.destroy_all
    end
  end

  #退会したユーザーはログインできないようにする
  def active_for_authentication?
    super && (user_status == true)
  end

  #ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  #検索機能
  def self.looks(search, words)
    if search == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    elsif search == "partial_match"
      @user = User.where("name LIKE ?", "\%#{words}\%")
    else
      @user = User.all
    end
  end
end