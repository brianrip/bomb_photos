class Admin::UsersController < Admin::BaseController
  before_action :find_studio, only: [:show, :index]
  before_action :require_correct_studio_admin, only: [:show, :index]

  def index
    @users = User.all
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
