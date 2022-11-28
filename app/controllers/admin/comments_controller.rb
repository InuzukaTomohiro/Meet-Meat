class Admin::CommentsController < ApplicationController
  layout "layouts/admin_application"
  # コメント一覧画面
  def index
    @tweet          = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all.order(created_at: :desc).page(params[:page]).per(10)
    @comments_all   = @tweet.comments.all
  end
  # コメントステータス更新、非同期済み
  def update
    @tweet   = Tweet.find(params[:tweet_id])
    @comment = Comment.find(params[:id])
    if @comment.is_active?
      @comment.update(is_active: false)
    else
      @comment.update(is_active: true)
    end
  end
  # コメント削除、非同期済み
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all.order(created_at: :desc).page(params[:page]).per(10)
    Comment.find(params[:id]).destroy
  end

end
