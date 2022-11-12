class Public::TweetsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tweet = Tweet.new
  end

  def index
    @tweets        = Tweet.all.order(created_at: :desc)
    @tweet_comment = Comment.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    daily_eat = DailyEat.find_by(created_at: Date.current.in_time_zone.all_day)
    if daily_eat.nil?
      daily_eat = current_user.daily_eats.new
      daily_eat.save
    end
    @tweet              = current_user.tweets.new(tweet_params)
    @tweet.daily_eat_id =  daily_eat.id
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to user_path(@tweet.user)
    else
      render :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:id]).destroy
    redirect_to user_path(tweet.user)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:meat_id, :body, :once_weight, :meat_image)
  end

end