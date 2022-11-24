class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"

  def index
    @tweets     = Tweet.all.page(params[:page]).per(10)
    @tweets_all = Tweet.all
  end

  def no_active
    @no_active_tweets = Tweet.where(is_active: false).page(params[:page]).per(10)
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.is_active?
      @tweet.update(is_active: false)
    else
      @tweet.update(is_active: true)
    end
  end

  def destroy
    tweet = Tweet.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "No." + (tweet.id).to_s + "のTweetを削除しました。"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:is_active)
  end

end
