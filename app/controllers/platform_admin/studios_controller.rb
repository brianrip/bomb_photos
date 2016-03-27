class PlatformAdmin::StudiosController < PlatformAdmin::BaseController
  def index
    @studios = Studio.all
  end

  def update
    studio = Studio.find(params[:id])
    if studio.active?
      studio.update_attribute(:status, 1)
      studio.deactivate_all_photos
      flash[:success] = "#{studio.name} has been deactivated"
    elsif studio.inactive?
      studio.update_attribute(:status, 0)
      studio.activate_all_photos
      flash[:success] = "#{studio.name} has been activated"
    elsif studio.pending? && params[:status] == "deny"
      studio.update_attribute(:status, 3)
      flash[:success] = "#{studio.name} has been denied"
    elsif studio.pending? && params[:status] == "approve"
      studio.update_attribute(:status, 0)
      flash[:success] = "#{studio.name} has been approved and activated"
    end
    redirect_to platform_admin_dashboard_path
  end
end
