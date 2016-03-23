require 'test_helper'

class LoggedInUserCreatesAnOrderTest < ActionDispatch::IntegrationTest

  test "user can see order summary" do
    user = User.create(username: "Brock", password: "password",
                       password_confirmation: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    photo = Photo.create(name: "dog in water", image_file_name: "test/asset_tests/photos/dog-swimming.jpeg", price: 200, description: "A happy labrador swims in a beautiful river.")

    photo.categories.create(name: "Animals")

    UserPhoto.create(photo_id: photo.id)

    order = user.orders.create(total: 200, status: 0)

    visit root_path

    click_on "Animals"
    click_on "photo of dog"
    click_on "add to cart"

    visit cart_path

    click_on "checkout"

    assert page.has_content? "Your order has been placed."
    assert page.has_content? order.total
    assert page.has_content? order.created_at
    assert page.has_link? "all photos"
    assert page.has_link? "all orders"
  end
end
