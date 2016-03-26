class UsersController < ApplicationController
  before_action :current_user, only: [:show, :edit, :update]

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

  def edit
    current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Your account has been updated!"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Invalid Input"
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_current_user
    current_user
  end

end
