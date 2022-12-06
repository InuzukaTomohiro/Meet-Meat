class Public::RelationshipsController < ApplicationController
  # ログイン済みuserのみアクセス許可
  before_action :authenticate_user!
  # 　フォロー一覧画面
  def followings
    @user            = User.find(params[:user_id])
    @following_users = @user.followings.all
  end
  # フォロワー一覧画面
  def followers
    @user           = User.find(params[:user_id])
    @follower_users = @user.followers
  end
  # フォロー登録(非同期)
  def create
    @user   = User.find(params[:user_id])
    @follow = current_user.follow(params[:user_id])
    # 通知のデータを作成
    @user.create_notification_follow!(current_user)
  end
  # フォロー解除（非同期）
  def destroy
    @user   = User.find(params[:user_id])
    @follow = current_user.unfollow(@user)
  end

end
