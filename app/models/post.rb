class Post < ApplicationRecord
  has_one_attached :image_book
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  #バリデーション
  validates :title, presence: true
  validates :body, presence: true

  #画像投稿機能
  def get_image_book
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

  #検索機能
  def self.looks(search, words)
    if search == "perfect_match"
      @posts = Post.where("title LIKE ?", "#{words}")
    elsif search == "partial_match"
      @posts = Post.where("title LIKE ?", "\%#{words}\%")
    else
      @posts = Post.all
    end
  end

  #タグ機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
     #古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: new)
    end
    #新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end
end

