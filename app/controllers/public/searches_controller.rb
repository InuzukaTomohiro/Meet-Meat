class Public::SearchesController < ApplicationController

  def tweet_search
    @tweets = Tweet.search(params[:keyword])
  end

  def user_search
    @users  = User.search(params[:keyword])
  end

end
