class Admin::PhotosController < Admin::BaseController
  def index
    @studio = Studio.find(params[:studio])
  end

  def new
    @photo = Photo.new
    @categories = Category.all
  end

  def create
    studio = Studio.find(params[:studio])
    @photo = Photo.new(photo_params)
    @photo.update_attributes(studio_id: studio.id)
    if @photo.save
      @photo.convert_price_to_cents
      flash[:success] = "Your Photo Has Been Created"
      redirect_to photo_path(@photo)
    else
      flash.now[:error] = "Invalid Entry, Try again."
      render new_admin_photo_path
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    @categories = Category.all
  end

  def update
    @photo = find_photo
    if @photo.update(photo_params)
      @photo.convert_price_to_cents
      flash[:success] = "Photo Has Been Updated"
      redirect_to photo_path(@photo.id)
    else
      flash.now[:error] = "Invalid input"
      render :edit
    end
  end

  def change_status
    @photo = Photo.find(params[:id])
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
