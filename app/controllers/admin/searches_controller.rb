class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_application"

  def tweet_search
    @keyword_tweets  = Tweet.search(params[:keyword]).page(params[:page]).per(10)
    @keyword         = params[:keyword]
    @tweet_comment   = Comment.new
  end

  def user_search
    @keyword_users  = User.search(params[:keyword]).page(params[:page]).per(10)
    @keyword        = params[:keyword]
  end

end
