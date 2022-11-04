class Public::FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

  def create
    favorite = Favorite.new(user_id: current_user.id, tweet_id: params[:tweet_id])
    favorite.save
    redirect_to tweets_path
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, tweet_id: params[:tweet_id])
    favorite.destroy
    redirect_to tweets_path
  end

end
