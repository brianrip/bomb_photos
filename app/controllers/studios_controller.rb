class StudiosController < ApplicationController
  def index
    @studios = Studio.where(status: 0)
  end

  def show
    @studio = Studio.find_by(slug: params[:id])
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

  def edit
    studio = Studio.find(params[:id])
    if (!current_platform_admin?) && (current_user.studio != studio)
      flash[:danger] = "You can only edit a studio that belongs to you"
      render file: "/public/404"
    else
      @studio = studio
    end
  end

  def update
    @studio = Studio.find(params[:id])
    if @studio.update(studio_params)
      flash[:success] = "Your studio has been updated!"
      redirect_to "/#{@studio.slug}"
    else
      flash[:danger] = "You must provide all information."
      render :edit
    end
  end

  private

    def studio_params
      params.require(:studio).permit(:name, :description, :promo_image)
    end
end
