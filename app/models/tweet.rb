class Tweet < ApplicationRecord

  belongs_to :user
  belongs_to :meat
  has_many   :comments,    dependent: :destroy
  has_many   :favorites,   dependent: :destroy

  validates :body,        presence: :true
  validates :meat_id,     presence: :true
  validates :once_weight, presence: :true, numericality: :only_integer

  has_one_attached :meat_image

  def get_meat_image(width, height)
    unless meat_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpeg")
      meat_image.attach(io: File.open(file_path), filename: "default-image.jpeg", content_type: "image/jpeg")
    end
    meat_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索機能
  def self.search(keyword)
    Tweet.where("body LIKE?", "%#{keyword}%")
  end

end
