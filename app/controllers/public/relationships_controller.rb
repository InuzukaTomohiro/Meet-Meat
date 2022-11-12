class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def followings
    @user            = User.find(params[:user_id])
    @following_users = @user.followings
  end

  def followers
    @user           = User.find(params[:user_id])
    @follower_users = @user.followers
  end

  def create
    @user           = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

end
