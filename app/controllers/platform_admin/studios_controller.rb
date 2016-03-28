class PlatformAdmin::StudiosController < PlatformAdmin::BaseController
  def index
    @studios = Studio.all
  end

  def update
    studio = Studio.find(params[:id])
    flash[:success] = StudioStatusUpdater.update(studio, params[:status])
    redirect_to platform_admin_dashboard_path
  end
end
