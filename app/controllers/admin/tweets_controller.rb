class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"

  def index
    @tweets     = Tweet.all.page(params[:page]).per(10)
    @tweets_all = Tweet.all
  end

  def no_active
    @tweets     = Tweet.all.page(params[:page]).per(10)
    @tweets_all = Tweet.all
  end

  def update
    tweet = Tweet.find(params[:id])
    status = tweet.find_by(is_active)
    if status == true
      tweet(is_active: false).update(tweet_params)
    elsif status == false
      tweet(is_active: true).update(tweet_params)
    end
    redirect_to admin_tweets_path
  end

  def destroy
    tweet = Tweet.find(params[:id]).destroy
    redirect_to admin_tweets_path
    flash[:notice] = "No." + (tweet.id).to_s + "のTweetを削除しました。"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:is_active)
  end

end
