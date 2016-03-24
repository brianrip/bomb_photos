require 'test_helper'

class LoggedInUserCreatesAnOrderTest < ActionDispatch::IntegrationTest

  test "user can see order summary" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    user = User.create(email:  "user@example.com",
                                password: "password",
                                role:     0
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    op = OrderPhoto.create(photo_id: photo.id)
    order = user.orders.create(total_price: 200)
    order.order_photos << op

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit root_path

    click_on "Example Category"
    click_on "Example Name"
    click_on "Add to Cart"

    visit cart_path

    click_on "Checkout"

    assert page.has_content? "Your order has been placed."
    assert page.has_content? order.total_price
    assert page.has_content? order.created_at
    # assert page.has_link? "all photos"
    # assert page.has_link? "all orders"
  end
end
