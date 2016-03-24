class StudiosController < ApplicationController
  def index
    @studios = Studio.where(status: 0)
  end

  def show
    @studio = Studio.find(params[:id])
  end
end
