class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  # コメント一覧機能
  def index
    @tweet          = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all.order(created_at: :desc).page(params[:page]).per(10)
    @comments_all   = @tweet.comments.all
    @tweet_comment  = Comment.new
  end
  # コメント編集機能
  def edit
    @tweet          = Tweet.find(params[:tweet_id])
    @comment        = Comment.find(params[:id])
  end
  # 非同期化済み
  def create
    @tweet            = Tweet.find(params[:tweet_id])
    @comment          = current_user.comments.new(comment_params)
    @comment.tweet_id = @tweet.id
    if @comment.save
      @tweet.create_notification_comment(current_user, @comment.id)
      @errors = []
    else
      @errors = @comment.errors.full_messages
    end
  end

  def update
    @tweet         = Tweet.find(params[:tweet_id])
    @comment       = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to tweet_comments_path(@tweet)
      flash[:notice] = "コメントの編集が完了しました。"
    else
      @errors = @comment.errors.full_messages
    end
  end
  # 非同期化済み
  def destroy
    @tweet          = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all.order(created_at: :desc).page(params[:page]).per(10)
    @comments_all   = @tweet.comments.all
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
