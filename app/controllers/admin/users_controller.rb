class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"

  def index
    @users     = User.all.page(params[:page]).per(10)
    @users_all = User.all
  end

  def no_active
    @users           = User.all.page(params[:page]).per(10)
    @no_active_users = User.where(is_active: false)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_users_path
    flash[:notice] = "ユーザー情報の編集が完了しました。"
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
