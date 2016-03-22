require 'test_helper'

class LoggedInUserCreatesAnOrderTest < ActionDispatch::IntegrationTest
  # As a registered/logged-in user,

  # when I visit the 'all photos' page,
  visit root_path

  click_on "Animals"
  # and I click on a category,
  click_on "photo of dog"
  # and I click on the photo,
  click_on "add to cart"
  # and I click on 'add to cart',
  visit cart_path
  # and I visit the cart,
  click_on "checkout"
  # and I click on 'checkout',
  # (in production, I should see stripe checkout),
  # then I should see a message 'your order has been placed',
  assert page.has_content? "Your order has been placed."
  # and I should see the order total,
  assert page.has_content? order.total
  assert page.has_content? order.created_at
  assert page.has_link? "all photos"
  assert page.has_link? "all orders"
  # and I should see the created at time/date,
  # and I should see a link to "all photos",
  # and I should see a link to all orders.
end
