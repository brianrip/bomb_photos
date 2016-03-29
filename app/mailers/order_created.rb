class OrderCreated < ApplicationMailer
  def order_success(user, cart)
    @user = user
    @cart = cart
    mail(to: user.email, subject: "Your order from Bomb Photos")
    number = 0

  end
end
