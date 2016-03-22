require 'test_helper'

class RegisteredUSerOrdersAuthorizationTest < ActionDispatch::IntegrationTest
  test "user who tries to view other user's order cannot" do
    business = Business.create(name: "Nature business", description: "description", status: 0)
    category = Category.create(name: "Nature")
    #NEEDS REAL IMAGE STUFF
    photo = category.photos.create(name: "name", description: "description", price: 2000, status: 0, image: "placeholder")
    business.photos << photo
    user = User.create(email: "adrienne@example.com", password: "password")
    other_user = User.create(email: "brian@example.com", password: "password")
    order = other_user.orders.create(total: 2000)
    OrderPhoto.create(photo_id: photo.id, order_id: order.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit order_path(order)
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
