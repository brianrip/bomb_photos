class Admin::UsersController < Admin::BaseController
  def show
    @studio = Studio.find(params[:studio])
  end

  def index
    require "pry"
    binding.pry
    @users = User.all
  end

  def change_admin_status
    @user = User.find(params[:id])
    if @user.studio_admin?
      @user.update_attribute(:studio_id, nil)
      @user.user_roles.each do |user_role|
        if user_role.role.name == "studio admin"
          @user.user_roles.find(user_role.id).delete
        end
      end
      flash[:success] = "User's admin privileges have been revoked"
    else
      @user.roles << Role.find_or_create_by(name: "studio admin")
      @user.update_attribute(:studio_id, current_user.studio.id)
      flash[:success] = "User has been granted admin status!"
    end
    redirect_to :back
  end
end
