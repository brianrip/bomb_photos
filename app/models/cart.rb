class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def add_photo(photo_id)
    if !contents.include?(photo_id)
      contents << photo_id
    end
  end

  def remove_photo(photo_id)
    contents.delete(photo_id)
  end

  def total_items
    contents.count
  end

  def total_price
    cart_photos.map do |cart_photo|
      cart_photo.price
    end.reduce(:+)
  end

  def cart_photos
    contents.map do |photo_id|
      CartPhoto.new(photo_id)
    end
  end

  def double_click?(photo_id)
    contents.include?(photo_id)
  end
end
