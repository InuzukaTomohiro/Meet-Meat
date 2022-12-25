class Admin::AchievementsController < ApplicationController
  before_action :authenticate_admin!
  layout "layouts/admin_application"

  def new
    @achievement = Achievement.new
  end

  def index
    @achievements = Achievement.all.order(:meat_id)
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to admin_achievements_path
    else
      render :new
    end
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update(achievement_params)
      redirect_to admin_achievements_path
    else
      render :edit
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title, :introduction, :is_get, :meat_id)
  end

end
