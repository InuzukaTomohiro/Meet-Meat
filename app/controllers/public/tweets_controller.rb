class Public::TweetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tweet = Tweet.new
  end

  def index
    @tweets        = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)
    @tweet_comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
      flash[:notice] = "新規投稿が完了しました。"
    else
      render :new
    end
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to user_path(@tweet.user)
      flash[:notice] = "投稿の編集が完了しました。"
    else
      render :edit
    end
  end

  def update_display
    @tweet = Tweet.find(params[:id])
    if @tweet.on_display?
      @tweet.update(on_display: false)
    else
      @tweet.update(on_display: true)
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to user_path(@tweet.user)
    flash[:notice] = "投稿の削除が完了しました。"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:meat_id, :body, :once_weight, :meat_image, :on_display)
  end

end