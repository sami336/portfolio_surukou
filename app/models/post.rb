class Post < ApplicationRecord
  has_one_attached :image_book
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags

  #画像投稿機能
  def get_image_book(width, height)
    unless image_book.attached?
      file_path = Rails.root.join('app/assets/images/no_book_image.png')
      image_book.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image_book
  end

  #いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end

