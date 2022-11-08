class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def tweet_search
    @keyword_tweets  = Tweet.search(params[:keyword])
    @keyword         = params[:keyword]
    @tweet_comment   = Comment.new
  end

  def user_search
    @keyword_users  = User.search(params[:keyword])
    @keyword        = params[:keyword]
  end

end
