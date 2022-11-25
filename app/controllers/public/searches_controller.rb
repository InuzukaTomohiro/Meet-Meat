class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def tweet_search
    @keyword_tweets  = Tweet.search(params[:keyword]).where(is_active: true, on_display: true).page(params[:page]).per(10)
    @keyword         = params[:keyword]
    @tweet_comment   = Comment.new
  end

  def user_search
    @keyword_users  = User.search(params[:keyword]).where(is_active: true).page(params[:page]).per(6)
    @keyword        = params[:keyword]
  end

end
