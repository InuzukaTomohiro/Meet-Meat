class Admin::CommentsController < ApplicationController
  layout "layouts/admin_application"

  def index
    @tweet          = Tweet.find(params[:tweet_id])
    @tweet_comments = @tweet.comments.all
  end


  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to admin_comments_path
      flash[:notice] = "ID<%= @comment.id %>のコメントの編集が完了しました。"
    else
      render :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    Comment.find(params[:id]).destroy
    redirect_to admin_tweet_comments_path(tweet)
    flash[:notice] = "コメントの削除が完了しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
