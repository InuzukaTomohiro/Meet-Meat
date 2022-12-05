class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets,        dependent: :destroy
  has_many :comments,      dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :relationships,            class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships,            source: :followed
  has_many :followers,  through: :reverse_of_relationships, source: :follower
  has_many :active_notifications,  class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :nick_name,    uniqueness: true, length: { in: 1..20 }
  validates :phone_number, uniqueness: true, length: { in: 10..11 }, numericality: :only_integer

  # プロフィール画像
  has_one_attached :profile_image
  # プロフィール画像設定
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/asset/images/default-image.jpeg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end

  # フォロー追加
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォロー解除
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローの確認
  def following?(user)
    followings.include?(user)
  end
  # 検索機能
  def self.search(keyword)
    User.where("nick_name LIKE?", "%#{keyword}%")
  end
  # 停止ユーザーログイン処置
  def active_for_authentication?
    super && (self.is_active == true)
  end
  # ゲストログインデータ
  def self.guest
    find_or_create_by!(nick_name: "guestuser", email: "guest@example.com", phone_number: "0000000000") do |user|
      user.password  = "aaaaaa"
      user.nick_name = "guestuser"
    end
  end

  # 通知機能（フォロー時）
  def create_notification_follow!(current_user)
    checking_follow = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, "follow"])
    if checking_follow.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      if notification.valid?
        notification.save
      end
    end
  end

end
