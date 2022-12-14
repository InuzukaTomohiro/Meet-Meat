# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストとしてログインしました。'
  end

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        flash[:notice] = "このアカウントは停止されています。詳細についてはお問い合わせください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "入力が正しくありません"
      end
    end
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

end
