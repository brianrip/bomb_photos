class StudiosController < ApplicationController
  def index
    @studios = Studio.where(status: "active")
  end

  def show
    @studio = Studio.find(params[:id])
  end
end
