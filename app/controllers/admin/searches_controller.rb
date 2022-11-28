class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  layout "admin_application"
  # 投稿検索一覧画面
  def tweet_search
    @keyword_tweets  = Tweet.search(params[:keyword]).page(params[:page]).per(10)
    @keyword         = params[:keyword]
  end
  # ユーザー検索一覧画面
  def user_search
    @keyword_users  = User.search(params[:keyword]).page(params[:page]).per(10)
    @keyword        = params[:keyword]
  end

  def destroy
    Tweet.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

end
