class PhotosController < ApplicationController
  def index
    @photos = Photo.all.page params[:page]
  end

  def show
    if params[:format]
      @photo = Photo.find(params[:format])
    else
      @photo = Photo.find(params[:id])
    end
    @studio = @photo.studio
  end
end
