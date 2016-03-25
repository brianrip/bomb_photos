require 'test_helper'

class CustomerCanViewADeactivatedPhotoTest < ActionDispatch::IntegrationTest
  test "customer views a deactivated photo" do
    category = create_category
    studio = create_studio
    user = create_user
    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id,
                                 active: false
                                 )

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    order = create_order(user, photo)

    visit dashboard_path
    click_on "My Orders"
    click_on "Order: #{order.id}"
    click_on order.photos.first.name
    assert page.has_content? "Sorry, this photo is no longer available"
    refute page.has_content? "Add to Cart"
  end
end
