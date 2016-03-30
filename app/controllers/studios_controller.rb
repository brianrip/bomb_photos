class StudiosController < ApplicationController
  before_action :find_studio, only: [:show, :edit, :update]
  before_action :require_correct_admin, only: [:edit]

  def index
    @studios = Studio.where(status: 0)
  end

  def show
    render file: "/public/404" unless @studio.active? || current_platform_admin? || current_user && current_user.studio == @studio
  end

  def new
    @studio = Studio.new
  end

  def create
    @studio = Studio.new(studio_params)
    if @studio.save
      StudioRelationships.build(@studio, current_user)
      flash[:success] = "Application submitted!"
      redirect_to dashboard_path
    else
      flash[:danger] = "You must provide all information."
      render :new
    end
  end

  def update
    if @studio.update(studio_params)
      flash[:success] = "Your studio has been updated!"
      redirect_to studio_show_path(@studio)
    else
      flash[:danger] = "You must provide all information."
      render :edit
    end
  end

private

  def studio_params
    params.require(:studio).permit(:name, :description, :promo_image)
  end

  def find_studio
    @studio = Studio.find(params[:id])
  end
end
