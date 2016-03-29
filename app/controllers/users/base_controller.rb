class Users::BaseController < ApplicationController
  before_action :require_correct_user

  def require_correct_user
    render file: "/public/404" unless current_user == User.find(params[:id])
  end
end
