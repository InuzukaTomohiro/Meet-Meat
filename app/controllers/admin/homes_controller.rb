class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_application"

  def top
    @users         = User.all
    @active_users  = @users.where(is_active: true)
    @stop_users    = @users.where(is_active: false)
    @tweets        = Tweet.all
    @on_display    = @tweets.where(on_display: true)
    @no_display    = @tweets.where(on_display: false)
    @active_tweets = @tweets.where(is_active: true)
    @stop_tweets   = @tweets.where(is_active: false)
    @total_weights = @tweets.group(:meat_id).sum(:once_weight)
  end

end
