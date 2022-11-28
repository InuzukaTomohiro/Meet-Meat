class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :tweet
  # 通知機能
  has_many   :notifications, dependent: :destroy

  validates :body, presence: :true

end
