class CartPhoto < SimpleDelegator
  def initialize(photo_id)
    @photo = Photo.find(photo_id)
    super(@photo)
  end
end
