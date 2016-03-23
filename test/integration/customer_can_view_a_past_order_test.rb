require 'test_helper'

class CustomerCanViewAPastOrderTest < ActionDispatch::IntegrationTest
  test "customer can see details of a past order" do

    user = User.create(username: "Brock", password: "password",
                       password_confirmation: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    photo = Photo.create(name: "dog in water", image_file_name: "test/asset_tests/photos/dog-swimming.jpeg", price: 200, description: "A happy labrador swims in a beautiful river.")

    photo.categories.create(name: "Animals")

    UserPhoto.create(photo_id: photo.id)

    order = user.orders.create(total: 200, status: 0)

    click_on "my orders"
    click_on "Order: #{order.id}"

    assert page.has_content? order.id
    assert page.has_content? order.created_at
    assert page.has_content? order.photos.first.name
    assert page.has_content? order.photos.first.image
    assert page.has_content? order.photos.first.price
    assert page.has_content? order.total
  end
end
