class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet          = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all
  end

  def edit
    @tweet          = Tweet.find(params[:tweet_id])
    @comment        = Comment.find(params[:id])
  end

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
      render :edit
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to tweet_comments_path(params[:tweet_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
