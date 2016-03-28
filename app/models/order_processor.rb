class OrderProcessor
  attr_reader :cart,
              :cart_photos,
              :user

  def initialize(cart, user)
    @cart = cart
    @cart_photos = cart.cart_photos
    @user = user
  end

  def process_order
    order = user.orders.create(total_price: cart.total_price, status: 0)
    cart_photos.each do | cart_photo |
      order.order_photos.create(photo_id: cart_photo.id)
      user.user_photos.create(photo_id: cart_photo.id)
    end
    order
  end
end
