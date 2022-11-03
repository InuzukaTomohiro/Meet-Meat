class Public::TweetsController < ApplicationController

  def new
    @tweet = Tweet.new
  end

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    tweet = current_user.tweets.new(tweet_params)
    tweet.save
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :meat_id, :body, :once_weight, :meat_image)
  end

end