class Admin::MeatsController < ApplicationController
  layout "layouts/admin_application"

  def new
    @meat = Meat.new
  end

  def edit
    @meat = Meat.find(params[:id])
  end

  def index
    @meats = Meat.all
  end

  def create
    @meat = Meat.new(meat_params)
    if @meat.save
      redirect_to admin_meats_path
      flash[:notice] = "ミートの登録が完了しました。"
    else
      render :new
    end
  end

  def update
    @meat = Meat.find(params[:id])
    if @meat.update(meat_params)
      redirect_to admin_meats_path
      flash[:notice] = "ミートの編集が完了しました。"
    else
      render :edit
    end
  end

  private

  def meat_params
    params.require(:meat).permit(:meat_type, :head_weight , :meat_profile_image)
  end

end
