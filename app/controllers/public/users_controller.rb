class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user          = User.find(params[:id])
    @tweets        = @user.tweets.all
    @daily_eats = @user.daily_eats.all
    @daily_eats.each do |daily_eat|
      daily_eat.tweets.each do |tweet|
        meat_id = tweet.meat_id
        if meat_id == meat_id
          @total_weight = tweet.once_weight += tweet.once_weight
        end
        @meat_type = Meat.find(@meat_id).meat_type
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def confirm
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
    flash[:notice] = "退会処理、全データの削除が完了しました。"
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :introduction, :profile_image, :phone_number, :email)
  end
  # ゲスト編集拒否
  def ensure_guest_user
    user = User.find(params[:id])
    if user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
