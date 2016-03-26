class PlatformAdmin::StudiosController < PlatformAdmin::BaseController
  def index
    @studios = Studio.all
  end

  def update
    studio = Studio.find(params[:id])
    if studio.active?
      studio.update(status: 1)
      studio.deactivate_all_photos
      flash[:success] = "#{studio.name} has been deactivated"
    elsif studio.inactive?
      studio.update(status: 0)
      studio.activate_all_photos
      flash[:success] = "#{studio.name} has been activated"
    end
    redirect_to platform_admin_dashboard_path
  end
end
