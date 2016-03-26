class CartPhoto < SimpleDelegator
  def initialize(photo_id)
    @photo = Photo.find(photo_id)
    super(@photo)
  end

  def subtotal
    price.to_f / 100
  end
end
