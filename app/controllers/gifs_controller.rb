17class GifsController < ApplicationController
  def index
    @gifs = Gif.all.page params[:page]
  end

  def show
    @gif = find_gif
    @charity = @gif.charity
  end

  def create
    @gif = Gif.new(gif_params)
    if @gif.save
      tags = params[:tags].split(",")
      @gif.create_tags(tags)
      Charity.find_by(name: params[:charity]).gifs << @gif
      flash[:success] = "Gif has been successfully added"
      redirect_to gif_path(@gif)
    else
      flash.now[:error] = "Invalid Entry, Try again."
      render new_admin_gif_path
    end
  end

  def update
    @gif = find_gif
    @gif.update_attributes(retired: true)
    redirect_to gif_path(@gif.id)
  end

private

  def gif_params
    params.require(:gif).permit(:title, :description, :price, :tag, :image)
  end
end
