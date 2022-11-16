class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites     = current_user.favorites.all.order(created_at: :desc).page(params[:page]).per(5)
    @tweet_comment = Comment.new
  end

  def create
    tweet     = Tweet.find(params[:tweet_id])
    @favorite = current_user.favorites.new(tweet_id: tweet.id)
    @favorite.save
    tweet.create_notification_like!(current_user)
  end

  def destroy
    tweet     = Tweet.find(params[:tweet_id])
    @favorite = current_user.favorites.find_by(tweet_id: tweet.id)
    @favorite.destroy
  end

end
