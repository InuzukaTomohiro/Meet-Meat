class Post < ApplicationRecord

  belongs_to :user
  has_many :post_meats
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :meat_image

  def get_meat_image(width, height)
    meat_image.variant(resize_to_limit: [width, height]).processed
  end

end
