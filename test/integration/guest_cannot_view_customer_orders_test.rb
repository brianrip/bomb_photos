require 'test_helper'

class GuestCannotViewCustomerOrdersTest < ActionDispatch::IntegrationTest
  test "attempt to see orders renders error page" do
    user = User.create(username: "Brock", password: "password",
                       password_confirmation: "password")

    photo = Photo.create(name: "dog in water", image_file_name: "test/asset_tests/photos/dog-swimming.jpeg", price: 200, description: "A happy labrador swims in a beautiful river.")
    UserPhoto.create(photo_id: photo.id)
    order = user.orders.create(total: 200, status: 0)
    visit root_path
    visit order_path(order.id)

    assert page.has_content? "The page you were looking for doesn't exist."

  end
end
