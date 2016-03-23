class SessionsController < ApplicationController
  def index

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
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
