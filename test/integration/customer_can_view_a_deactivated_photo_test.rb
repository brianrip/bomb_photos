require 'test_helper'

class CustomerCanViewADeactivatedPhotoTest < ActionDispatch::IntegrationTest
  test "customer views a deactivated photo" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    user = studio.users.create(email:  "user@example.com",
                                password: "password",
                                role:     0
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id,
                                 active: false
    )

    op = OrderPhoto.create(photo_id: photo.id)
    order = user.orders.create(total_price: 200)
    order.order_photos << op

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path
    click_on "My Orders"
    click_on "Order: #{order.id}"
    click_on order.photos.first.name

    assert page.has_content? "Sorry, this photo is no longer available"
    refute page.has_content? "Add to Cart"
  end
end
