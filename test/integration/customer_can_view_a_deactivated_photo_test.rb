require 'test_helper'

class CustomerCanViewADeactivatedPhotoTest < ActionDispatch::IntegrationTest
  test "customer views a deactivated photo" do
    user = User.create(username: "Brock", password: "password",
                       password_confirmation: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    photo = Photo.create(name: "dog in water", image_file_name: "test/asset_tests/photos/dog-swimming.jpeg", price: 200, description: "A happy labrador swims in a beautiful river.", retired: true)

    photo.categories.create(name: "Animals")

    UserPhoto.create(photo_id: photo.id)

    order = user.orders.create(total: 200, status: 0)

    click_on "my orders"
    click_on "Order: #{order.id}"
    click_on order.photos.first.name

    assert page.has_content? "photo no longer available"
    refute page.has_content? "add to cart"
  end
end
