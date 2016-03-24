class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_photo(photo_id)
    contents[photo_id.to_s] ||= 0
    contents[photo_id.to_s] += 1
  end

  def remove_photo(photo_id)
    contents.reject! { |id| id == photo_id.to_s }
  end

  def total_items
    contents.values.sum
  end

  def total_price
    prices = cart_photos.map do |cart_photo|
      (cart_photo.quantity * cart_photo.price)
    end
    prices.reduce(:+)
  end

  def cart_photos
    contents.map do |photo_id, quantity|
      CartPhoto.new(photo_id, quantity)
    end
  end
end
