class Admin::UsersController < Admin::BaseController
  def show
    @studio = Studio.find(params[:studio])
  end
end
