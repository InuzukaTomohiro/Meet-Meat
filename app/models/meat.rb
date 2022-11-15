class Meat < ApplicationRecord

  has_many :tweets

  validates :meat_type,   presence: :true
  validates :head_weight, presence: :true, numericality: :only_integer

  # ミートプロフィール画像
  has_one_attached :meat_profile_image
  # ミートプロフィール画像設定
  def get_meat_profile_image(width, height)
    unless meat_profile_image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpeg")
      meat_profile_image.attach(io: File.open(file_path), filename: "default-image.jpeg", content_type: "image/jpeg")
    end
    meat_profile_image.variant(resize_to_fill: [width, height]).processed
  end

end
