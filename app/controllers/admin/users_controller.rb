class Admin::UsersController < Admin::BaseController
  def show
    @studio = Studio.find(params[:studio])
  end

  def index
    @users = User.all
  end

  def change_admin_status
    @user = User.find(params[:id])
    if @user.admin?
      @user.update_attributes(role: 0)
      flash[:success] = "#{@user.email} no longer has admin status!"
    else
      @user.update_attributes(role: 1)
      flash[:success] = "#{@user.email} has been granted admin status!"
    end
    redirect_to :back
  end

end
