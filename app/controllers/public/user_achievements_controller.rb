class Public::UserAchievementsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @user_achievements = @user.user_achievements.all
  end

  def update
    @user = User.find(params[:user_id])
    @user_achievement = UserAchievement.find(params[:id])
    if @user_achievement.on_display == true
      @user_achievement.update(on_display: false)
    elsif @user.user_achievements.find_by(on_display: true)
      @user = User.find(params[:user_id])
      @user_achievements = @user.user_achievements.all
      @error = "選択中を解除してください。"
    else
      @user_achievement.update(on_display: true)
    end
  end

end
