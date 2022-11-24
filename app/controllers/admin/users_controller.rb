class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"

  def index
    @users     = User.all.page(params[:page]).per(10)
    @users_all = User.all
  end

  def show
    @user          = User.find(params[:id])
    @tweets        = @user.tweets.all.order(created_at: :desc).page(params[:page]).per(5)
    @total_weights = @tweets.group(:meat_id).sum(:once_weight)
  end

  def no_active
    @no_active_users = User.where(is_active: false).page(params[:page]).per(10)
  end

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
