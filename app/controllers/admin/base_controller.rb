class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404" unless current_studio_admin?
  end

  def require_correct_studio_admin
    render file: "/public/404" unless current_studio_admin? && current_user.studio.id == params[:studio].to_i
  end
end
