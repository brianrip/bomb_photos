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
    if params[:admin_users]
      @user = User.find_by(email: params[:admin_users][:email])
      studio = Studio.find_by(slug: params[:admin_users][:studio_slug])
    else
      @user = User.find_by(id: params[:user_id])
      studio = Studio.find_by(slug: params[:studio_id])
    end
    type, message = UserStatus.update(@user, current_user, studio)
    flash[type] = message
    redirect_to :back
  end
end
