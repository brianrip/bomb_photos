require 'test_helper'

class CustomerCanViewMultiplePastOrdersTest < ActionDispatch::IntegrationTest
  test "customer can see details of a past order" do

    user = User.create(username: "Brock", password: "password",
                       password_confirmation: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    photo = Photo.create(name: "dog in water", image_file_name: "test/asset_tests/photos/dog-swimming.jpeg", price: 200, description: "A happy labrador swims in a beautiful river.")

    photo.categories.create(name: "Animals")

    UserPhoto.create(photo_id: photo.id)

    order1 = user.orders.create(total: 200, status: 0)
    order2 = user.orders.create(total: 400, status: 0)

    click_on "my orders"

    assert page.has_content? order1.id
    assert page.has_content? order1.created_at
    assert page.has_content? order1.total
    assert page.has_content? order2.id
    assert page.has_content? order2.created_at
    assert page.has_content? order2.total
  end
end
