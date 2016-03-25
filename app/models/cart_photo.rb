class CartPhoto < SimpleDelegator
  # attr_reader :quantity

  def initialize(photo_id)
    @photo = Photo.find(photo_id)
    # @quantity = quantity
    super(@photo)
  end

  def subtotal
    price.to_f / 100
  end
end
