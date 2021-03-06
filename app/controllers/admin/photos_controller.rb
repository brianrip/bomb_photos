class Admin::PhotosController < Admin::BaseController
  before_action :find_studio, only: [:index, :create, :change_status]
  before_action :find_photo,  only: [:edit,  :update, :change_status]

  def new
    @photo = Photo.new
    @categories = Category.all
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.update_attributes(studio_id: @studio.id)
    if @photo.save
      @photo.convert_price_to_cents
      flash[:success] = "Your Photo Has Been Created"
      redirect_to photo_path(@photo)
    else
      flash.now[:danger] = "Invalid Entry, Try again."
      render new_admin_photo_path
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @photo.update(photo_params)
      @photo.convert_price_to_cents
      flash[:success] = "Photo Has Been Updated"
      redirect_to photo_path(@photo.id)
    else
      flash.now[:danger] = "Invalid input"
      render :edit
    end
  end

  def change_status
    unless @studio.status == "active"
      flash[:danger] = "That action is prohibited."
      redirect_to :back and return
    end

    if @photo.active
      @photo.update_attributes(active: false)
      flash[:success] = "Photo Has Been Deactivated"
    else
      @photo.update_attributes(active: true)
      flash[:success] = "Photo Has Been Activated"
    end
    redirect_to :back
  end

private

  def photo_params
    params.require(:photo).permit(:name, :description, :price, :category_id, :image, :active)
  end

  def redirect_to_back(default = root_url)
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end
end
