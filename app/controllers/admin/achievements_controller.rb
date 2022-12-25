class Admin::AchievementsController < ApplicationController

  def new
    @achievement = Achievement.new
  end

  def index
    @achivements = Achievement.all
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    achievement = Achievement.new(achievement_params)
    if achievement.save
      redirect_to achievements_path
    else
      render :new
    end
  end

  def update
    achievement = Achievement.find(params[:id])
    if achievement.update(achievement_params)
      redirect_to achievements_path
    else
      render :edit
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :is_get)
  end

end
