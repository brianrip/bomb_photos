require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should validate_presence_of(:status)
  # should validate_presence_of(:total_price)
  # should validate_numericality_of(:total_price).
    # is_greater_than(0)
  should belong_to(:user)
  should have_many(:order_photos)
  should have_many(:photos)

  test "order status returns correct order status" do
    user = User.create(email: "Jade", password: "passsword")
    order1 = user.orders.create(status: 2)
    order2 = user.orders.create(status: 3)
    order3 = user.orders.create(status: 0)

    assert_equal "Order Complete on #{order1.updated_at}", order1.order_status
    assert_equal "Order cancelled on #{order2.updated_at}", order2.order_status
    assert_equal "In progress", order3.order_status
  end

  test "revenue returns studio revenue"
end
end
