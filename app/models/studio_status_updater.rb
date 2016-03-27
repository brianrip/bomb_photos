class StudioStatusUpdater
  def self.update(studio, status)
    if studio.active?
      studio.update_attribute(:status, 1)
      studio.deactivate_all_photos
      message = "#{studio.name} has been deactivated"
    elsif studio.inactive?
      studio.update_attribute(:status, 0)
      studio.activate_all_photos
      message = "#{studio.name} has been activated"
    elsif studio.pending? && status == "deny"
      studio.update_attribute(:status, 3)
      message = "#{studio.name} has been denied"
    elsif studio.pending? && status == "approve"
      studio.update_attribute(:status, 0)
      message = "#{studio.name} has been approved and activated"
    end
    message
  end
end
