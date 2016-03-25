class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for creating an account!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Invalid Input"
      render :new
    end
  end

  def show
    current_user
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
