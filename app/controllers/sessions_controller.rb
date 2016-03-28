class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if session[:return_to]
        redirect_to session[:return_to]
      elsif current_user.platform_admin?
        redirect_to platform_admin_dashboard_path
      elsif current_user.studio_admin?
        redirect_to admin_path(current_user.studio)
      else
        redirect_to dashboard_path
      end
    else
      flash.now[:error] = "Invalid Login"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
