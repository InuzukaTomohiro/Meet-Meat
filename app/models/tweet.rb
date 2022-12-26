class Tweet < ApplicationRecord

  belongs_to :user
  belongs_to :meat
  has_many   :comments,      dependent: :destroy
  has_many   :favorites,     dependent: :destroy
  has_many   :notifications, dependent: :destroy

  validates :body,        presence: :true
  validates :once_weight, presence: :true, numericality: :only_integer

  scope :active_tweets,  -> {where(is_active: true, on_display: true)}
  scope :stop_tweets,    -> {where(is_active: false)}
  scope :latest,         -> {order(created_at: :desc)}
  scope :old,            -> {order(created_at: :asc)}

  # 投稿画像
  has_one_attached :meat_image
  # 投稿画像設定
  def get_meat_image(width, height)
    unless meat_image.attached?
      file_path = Rails.root.join("app/javascript/images/default-image.jpeg")
      meat_image.attach(io: File.open(file_path), filename: "default-image.jpeg", content_type: "image/jpeg")
    end
    meat_image.variant(resize_to_limit: [width, height]).processed
  end
  # いいね済みの判別
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索機能
  def self.search(keyword)
    Tweet.where("body LIKE?", "%#{keyword}%")
  end

  # 通知機能（Tweetにいいねをした時)
  def create_notification_like!(current_user)
    # visitor = 通知を送る側、visited = 通知を受け取る側、action = 通知の種類
    checking_favorite = Notification.where(visitor_id: current_user.id, visited_id: user_id, tweet_id: id, action: "favorite")
    # いいねの通知が存在しない場合、通知データを作成する
    if checking_favorite.blank?
      notification = current_user.active_notifications.new(
        tweet_id:   id,
        visited_id: user_id,
        action:     "favorite"
      )
      # 自分の投稿にいいねをした場合、通知が来ないようにtrueに設定する
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

   # 通知機能（Tweetにコメントをした時）
  def save_notification_comment(current_user, comment_id, visited_id)
    # コメントの通知データ作成
    notification = current_user.active_notifications.new(
      tweet_id:   id,
      comment_id: comment_id,
      visited_id: visited_id,
      action:     "comment"
    )
    # 自分の投稿にコメントをした場合、通知が来ないようにtrueに設定する
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # 通知の判別機能
  def create_notification_comment(current_user, comment_id)
    # 投稿にコメントしているユーザーをすべて取得し、ユーザーごとにまとめる。（自分以外）
    comment_user_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    comment_user_ids.each do |comment_user_id|
      # コメントしている各ユーザーに通知を送る
      save_notification_comment(current_user, comment_id, comment_user_id["user_id"])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    if comment_user_ids.blank?
      save_notification_comment(current_user, comment_id, user_id)
    end
  end

  # 称号獲得機能
  def create_achievement!(current_user)
    user_total_meats = current_user.tweets.group(:meat_id).sum(:once_weight)
    user_total_meats.each do |id, weight|
      if id == 1
        def achievement(weight)
          if    weight > 5000 then  10
          elsif weight > 4500 then  9
          elsif weight > 4000 then  8
          elsif weight > 3500 then  7
          elsif weight > 3000 then  6
          elsif weight > 2500 then  5
          elsif weight > 2000 then  4
          elsif weight > 1500 then  3
          elsif weight > 1000 then  2
          elsif weight > 500  then  1
          end
        end
      end
      n = achievement(weight)
      unless current_user.user_achievements.exists?(achievement_id: n)
        current_user.user_achievements.create(achievement_id: n)
      end
      n = achievement(weight).to_i - 1
      if current_user.user_achievements.exists?(achievement_id: n)
        n.times do
          n -= 1
          unless current_user.user_achievements.exists?(achievement_id: n)
            current_user.user_achievements.create(achievement_id: n)
          end
        end
      end
    end
  end

end
