class PlatformAdmin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404" unless current_platform_admin?
  end

  def all_studios
    @studios = Studio.all
  end
end
