class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"
  # 投稿一覧画面
  def index
    @tweets_all = Tweet.all
    if    params[:latest]
      @tweets = Tweet.latest.page(params[:page]).per(10)
    elsif params[:old]
      @tweets = Tweet.old.page(params[:page]).per(10)
    elsif params[:favorite_count]
      tweets  = Tweet.all.sort{|a,b| b.favorites.size <=> a.favorites.size}
      @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)
    elsif params[:comment_count]
      tweets  = Tweet.all.sort{|a,b| b.comments.size <=> a.comments.size}
      @tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)
    else
      @tweets = Tweet.all.page(params[:page]).per(10)
    end
  end
  # 停止投稿一覧画面
  def no_active
    if    params[:latest]
      @no_active_tweets = Tweet.stop_tweets.latest.page(params[:page]).per(10)
    elsif params[:old]
      @no_active_tweets = Tweet.stop_tweets.old.page(params[:page]).per(10)
    elsif params[:favorite_count]
      tweets  = Tweet.stop_tweets.sort{|a,b| b.favorites.size <=> a.favorites.size}
      @no_active_tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)
    elsif params[:comment_count]
      tweets  = Tweet.stop_tweets.sort{|a,b| b.comments.size <=> a.comments.size}
      @no_active_tweets = Kaminari.paginate_array(tweets).page(params[:page]).per(10)
    else
      @no_active_tweets = Tweet.stop_tweets.latest.page(params[:page]).per(10)
    end
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
