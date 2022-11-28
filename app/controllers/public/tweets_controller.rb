class Public::TweetsController < ApplicationController
  before_action :authenticate_user!
  # 新規投稿画面
  def new
    @tweet = Tweet.new
  end
  # 投稿一覧画面
  def index
    @tweet_comment = Comment.new
    @tweets        = Tweet.where(is_active: true, on_display: true).order(created_at: :desc).page(params[:page]).per(10)
  end
  # 投稿編集画面
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
  # 公開設定更新
  def update_display
    @tweet = Tweet.find(params[:id])
    if @tweet.on_display?
      @tweet.update(on_display: false)
    else
      @tweet.update(on_display: true)
    end
  end

  def destroy
    tweet       = Tweet.find(params[:id])
    user        = tweet.user
    # ユーザー詳細画面の投稿一覧非同期化用
    @tweets     = user.tweets.all.order(created_at: :desc).page(params[:page]).per(5)
    # ユーザー詳細画面の投稿数非同期化用
    @tweets_all = user.tweets.all
    tweet.destroy
  end

  private

  def tweet_params
    params.require(:tweet).permit(:meat_id, :body, :once_weight, :meat_image, :on_display)
  end

end