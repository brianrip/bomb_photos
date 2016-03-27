class Admin::UsersController < Admin::BaseController
  def show
    require_correct_studio_admin
    @studio = Studio.find(params[:studio])
  end

  def index
    require_correct_studio_admin
    @users = User.all
    @studio = params[:studio].to_i
  end

  def change_admin_status
    @user = User.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot remove yourself at this time, please contact Bomb Photos to perform this action."
    elsif @user.studio_admin?
      @user.update_attribute(:studio_id, nil)
      @user.user_roles.each do |user_role|
        if user_role.role.name == "studio admin"
          @user.user_roles.find(user_role.id).delete
        end
      end
      flash[:success] = "You have removed admin status for #{@user.email}"
    else
      @user.roles << Role.find_or_create_by(name: "studio admin")
      @user.update_attribute(:studio_id, params[:studio_id])
      flash[:success] = "#{@user.email} has been granted admin status!"
    end
    redirect_to :back
  end
end
