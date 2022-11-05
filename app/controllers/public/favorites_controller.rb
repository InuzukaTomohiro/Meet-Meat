class Public::FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

  def create
    tweet    = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: tweet.id)
    favorite.save
    redirect_to tweets_path
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find_by(tweet_id: tweet.id)
    favorite.destroy
    redirect_to tweets_path
  end

end
