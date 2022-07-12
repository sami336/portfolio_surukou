class Post < ApplicationRecord
  has_one_attached :image_book
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :post_tags
  
end
