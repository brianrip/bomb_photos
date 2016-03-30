class PlatformAdmin::StudiosController < PlatformAdmin::BaseController
  before_action :all_studios, except: [:update]

  def update
    studio = Studio.find(params[:id])
    flash[:success] = StudioStatusUpdater.update(studio, params[:status])
    redirect_to platform_admin_dashboard_path
  end
end
