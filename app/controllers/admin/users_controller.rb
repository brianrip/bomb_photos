class Admin::UsersController < Admin::BaseController
  def show
    @studio = Studio.find(params[:studio])
  end

  def index
    @users = User.all
  end

  def change_admin_status
    @user = User.find(params[:id])
    if @user.studio_admin?
      @user.roles.first.update_attributes(name: "customer")
      @user.update_attributes(studio_id: nil)
      flash[:success] = "#{@user.email} no longer has admin status!"
    else
      @user.roles.first.update_attributes(name: "studio admin")
      current_user.studio.users << @user
      flash[:success] = "#{@user.email} has been granted admin status!"
    end
    redirect_to :back
  end

end
