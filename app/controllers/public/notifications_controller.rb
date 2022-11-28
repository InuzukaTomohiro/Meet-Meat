class Public::NotificationsController < ApplicationController

  # 通知機能一覧画面
  def index
    notifications = current_user.passive_notifications
    notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = notifications.where.not(visitor_id: current_user.id)
  end

end
