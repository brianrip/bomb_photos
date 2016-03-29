class OrderCreated < ApplicationMailer
  def order_success(user)
    @user = user
    mail(to: user.email, subject: "Your order from Bomb Photos")
    number = 0

  end
end
