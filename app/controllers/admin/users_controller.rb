class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"
  # ユーザー一覧画面
  def index
    # @users     = User.all.page(params[:page]).per(10)
    @users_all = User.all

    if params[:create_id]
      @user  = User.all.order(created_at: :desc).page(params[:page]).per(10)
    elsif  params[:follower_count]
      users  = User.all
                  .sort{|a,b| b.followers.size <=> a.followers.size}
      @users = Kaminari.paginate_array(users).page(params[:page]).per(10)
    elsif params[:tweet_count]
      users  = User.all
                  .sort{|a,b| b.tweets.size <=> a.tweets.size}
      @users = Kaminari.paginate_array(users).page(params[:page]).per(10)
    else
      @users = User.all.page(params[:page]).per(10)
    end
  end
  # ユーザー詳細画面
  def show
    @user          = User.find(params[:id])
    @tweets        = @user.tweets.all.order(created_at: :desc).page(params[:page]).per(5)
    @total_weights = @tweets.group(:meat_id).sum(:once_weight)
  end
  # 停止ユーザー一覧画面
  def no_active
    @no_active_users_all = User.where(is_active: false)
    # @no_active_users     = User.where(is_active: false).page(params[:page]).per(10)
    if params[:create_id]
      @no_active_users = User.where(is_active: false).page(params[:page]).per(10)
    elsif  params[:follower_count]
      users = User.where(is_active: false)
                  .sort{|a,b| b.followers.size <=> a.followers.size}
      @no_active_users = Kaminari.paginate_array(users).page(params[:page]).per(10)
    elsif params[:tweet_count]
      users = User.where(is_active: false)
                  .sort{|a,b| b.tweets.size <=> a.tweets.size}
      @no_active_users = Kaminari.paginate_array(users).page(params[:page]).per(10)
    else
      @no_active_users     = User.where(is_active: false).page(params[:page]).per(10)
    end
  end
  # ユーザー編集画面
  def edit
    @user = User.find(params[:id])
    session[fallback_location: root_path] = request.referer
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to session[fallback_location: root_path]
      flash[:notice] = "ユーザー情報の編集が完了しました。"
    else
      render :edit
    end
  end
  # ユーザーステータス更新、非同期化
  def update_status
    @user = User.find(params[:id])
    if @user.is_active?
      @user.update(is_active: false)
    else
      @user.update(is_active: true)
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :introduction, :profile_image, :phone_number, :email, :is_active)
  end

end
