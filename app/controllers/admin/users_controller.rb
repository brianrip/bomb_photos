class Admin::UsersController < Admin::BaseController

  def show
    @studio = current_user.studio
  end
end
