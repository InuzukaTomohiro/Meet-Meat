class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"
  # 投稿一覧画面
  def index
    @tweets     = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
    @tweets_all = Tweet.all
  end
  # 停止投稿一覧画面
  def no_active
    @no_active_tweets = Tweet.where(is_active: false).order(created_at: :desc).page(params[:page]).per(10)
  end
  # 投稿ステータス更新、非同期化済み
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.is_active?
      @tweet.update(is_active: false)
    else
      @tweet.update(is_active: true)
    end
  end
  # 投稿削除機能、非同期化済み
  def destroy
    @tweet            = Tweet.find(params[:id])
    @tweets           = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
    @tweets_all       = Tweet.all
    @no_active_tweets = Tweet.where(is_active: false).order(created_at: :desc).page(params[:page]).per(10)
    user              = @tweet.user
    @user_tweets      = user.tweets.all.order(created_at: :desc).page(params[:page]).per(5)
    @tweet.destroy
  end

  private

  def tweet_params
    params.require(:tweet).permit(:is_active)
  end

end
