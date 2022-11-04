class Public::CommentsController < ApplicationController

  def index
    @tweet    = Tweet.find(params[:tweet_id])
    @comments = @tweet.comments.all
  end

  def create
    tweet            = Tweet.find(params[:tweet_id])
    comment          = current_user.comments.new(comment_params)
    comment.tweet_id = tweet.id
    comment.save
    redirect_to tweets_path
  end

  def edit

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
