class Public::AchievementsController < ApplicationController
  # ログインユーザーのみ閲覧可能
  before_action :authenticate_user!
  
  def create
    achievement = current_user.achievements.new(achievement_params)
    achievement.save
    redirect_to 
  end
  
  private
  
  def achievement_params
    params.require(:achievement).permit(:title)
  end
  
end
