require 'test_helper'

class CustomerCanViewADeactivatedPhotoTest < ActionDispatch::IntegrationTest
  test "customer views a deactivated photo" do
    user = User.create(username: "Brock", password: "password",
                       password_confirmation: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    photo = Photo.create(name: "dog in water", image_file_name: "test/asset_tests/photos/dog-swimming.jpeg", price: 200, description: "A happy labrador swims in a beautiful river.")

    photo.categories.create(name: "Animals")

    UserPhoto.create(photo_id: photo.id)

    order = user.orders.create(total: 200, status: 0)

    visit root_path

    click_on "Animals"
  end
  # As a registered/logged-in customer,
  # when I visit my past orders,
  # and I click on a past order,
  # and I click on the photo name of a deactivated photo,
  # then I should see the photo page,
  # and I should see 'photo is no longer available',
  # and I should not see 'add to cart'.

end
