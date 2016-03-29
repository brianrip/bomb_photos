class UserStatus
  def self.update(user, current_user, studio)
    if user == nil
      message = "You entered an invalid email."
      type = "danger"
    elsif user == current_user
      message = "You cannot remove yourself at this time, please contact Bomb Photos to perform this action."
      type = "danger"
    elsif user.studio_admin?
      user.update_attribute(:studio_id, nil)
      user.delete_studio_admin_role
      message = "You have removed admin status for #{user.email}"
      type = "success"
    else
      user.roles << Role.find_or_create_by(name: "studio admin")
      user.update_attribute(:studio_id, studio.id)
      message = "#{user.email} has been granted admin status!"
      type = "success"
    end
    [type, message]
  end
end
