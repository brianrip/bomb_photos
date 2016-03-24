class CartPhotosController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    photo = Photo.find(params[:photo_id])
    session[:cart] = @cart.contents
    unless @cart.double_click?(photo.id)
      @cart.add_photo(photo.id)
      flash[:success] = "Photo has been added to cart"
    end
    flash[:alert] = "That photo is already in your cart" if @cart.double_click?(photo.id)
    redirect_to photos_path
  end

  def show
    ids = session[:cart]
    @cart_photos = @cart.cart_photos
    session[:return_to] = cart_path
  end

  def destroy
    photo = find_photo
    @cart.remove_photo(photo.id)
    flash[:success] = "#{view_context.link_to photo.name, photo_path(photo.id)} has been removed from your cart"
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
