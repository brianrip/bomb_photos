class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404" unless current_studio_admin? || current_platform_admin?
  end

  def require_correct_studio_admin
    render file: "/public/404" unless current_studio_admin? && current_user.studio == Studio.find_by(slug: params[:studio]) || current_platform_admin?
  end

  def find_studio
    @studio = Studio.find_by(slug: params[:studio])
  end
end
