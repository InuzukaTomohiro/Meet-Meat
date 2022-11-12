class Public::NotificationsController < ApplicationController

  def index

    notifications = current_user.passive_notifications
    notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @notifications = notifications.where.not(visitor_id: current_user.id)
    # @visitor = notification.visitor
    # @visited = notification.visited
  end

end
