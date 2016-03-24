class PlatformAdmin::StudiosController < PlatformAdmin::BaseController

  def index
    @studios = Studio.all
  end
end
