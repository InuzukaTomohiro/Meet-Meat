class Admin::TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
  end

  def destroy
    tweet = Tweet.find(params[:id]).destroy
    redirect_to admin_tweets_path
    flash[:notice] = "No." + (tweet.id).to_s + "のTweetを削除しました。"
  end

end
