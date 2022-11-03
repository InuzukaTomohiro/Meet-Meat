class Post < ApplicationRecord

  belongs_to :user
  has_many :post_meats
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

end
