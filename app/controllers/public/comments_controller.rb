class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet          = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all
  end

  def edit
    @tweet    = Tweet.find(params[:tweet_id])
    @comment  = Comment.find(params[:id])
  end

  def create
    tweet            = Tweet.find(params[:tweet_id])
    comment          = current_user.comments.new(comment_params)
    comment.tweet_id = tweet.id
    comment.save
    redirect_to tweets_path
  end

  def update
    tweet         = Tweet.find(params[:tweet_id])
    @tweet_comment = tweet.comments.find_by(params[:id])
    @tweet_comment.update(comment_params)
    redirect_to tweet_comments_path(tweet)
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
