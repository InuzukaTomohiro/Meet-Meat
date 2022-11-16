class Tweet < ApplicationRecord

  belongs_to :user
  belongs_to :meat
  has_many   :comments,      dependent: :destroy
  has_many   :favorites,     dependent: :destroy
  has_many   :notifications, dependent: :destroy

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

  # 通知機能（Tweetにいいねをした時)
  def create_notification_like!(current_user)
  temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # 通知の判別機能
  def create_notification_comment(current_user, comment_id)
    # コメントしている人をすべて取得し、全員に通知を送る（自分以外）
    temp_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    if temp_ids.blank?
      save_notification_comment(current_user, comment_id, user_id)
    end
  end

  # 通知機能（Tweetにコメントをした時）
  def save_notification_comment(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    if notification.valid?
      notification.save
    end
  end

end
