class Admin::UsersController < Admin::BaseController
  def show
    require_correct_studio_admin
    @studio = Studio.find(params[:studio])
  end

  def index
    require_correct_studio_admin
    @users = User.all
    @studio = Studio.find_by(slug: params[:studio])
  end

  def change_admin_status
    @user = User.find(params[:id])
    studio = Studio.find_by(slug: params[:studio_id])
    message = UserStatus.update(@user, current_user, studio)
    flash[:success] = message
    redirect_to :back
  end
end
