class CartPhotosController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    photo = Photo.find(params[:photo_id])
    @cart.add_photo(photo.id)
    session[:cart] = @cart.contents
    flash[:success] =
      "Photo has been added to cart"
    redirect_to photos_path
  end

  def show
    ids = session[:cart]
    @cart_photos = @cart.cart_photos
  end

  def destroy
    photo = find_photo
    @cart.remove_photo(photo.id)
    flash[:success] = "Successfully removed license for
    #{view_context.link_to photo.title, photo_path(photo.id)}"
    if @cart.contents.empty?
      redirect_to photos_path
    else
      redirect_to cart_path
    end
  end

  def update
    photo = find_photo
    quantity = params[params[:id]].values.first.to_i
    @cart.contents[params[:id]] = quantity
    redirect_to cart_path
    flash[:success] = "Successfully updated quantity for #{photo.title} to #{quantity}"
  end
end
