class StudiosController < ApplicationController
  def index
    @studios = Studio.where(status: 0)
  end

  def show
    @studio = Studio.find(params[:id])
  end

  def new
    @studio = Studio.new
  end

  def create
    @studio = Studio.new(studio_params)
    if @studio.save
      @studio.update(status: 2)
      current_user.update(role: 1, studio_id: @studio.id)
      flash[:success] = "Application submitted!"
      redirect_to dashboard_path
    else
      flash[:alert] = "You must provide all information."
      render :new
    end
  end

  def edit
    studio = Studio.find(params[:id])
    if current_user.studio != studio
      flash[:alert] = "You can only edit a studio that belongs to you"
      render file: "/public/404"
    else
      @studio = studio
    end
  end

  def update
    @studio = Studio.find(params[:id])
    if @studio.update(studio_params)
      flash[:success] = "Your studio has been updated!"
      redirect_to studio_path(@studio)
    else
      flash[:alert] = "You must provide all information."
      render :edit
    end
  end

  private

    def studio_params
      params.require(:studio).permit(:name, :description, :promo_image)
    end
end
