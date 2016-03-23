require 'test_helper'

class RegisteredUSerOrdersAuthorizationTest < ActionDispatch::IntegrationTest
  test "user who tries to view other user's order cannot" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    user = studio.users.create(email:  "user@example.com",
                                password: "password",
                                role:     0
    )
    other_user = studio.users.create(email:  "other_user@example.com",
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
    order = other_user.orders.create(total_price: 999)
    order.order_photos << op
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit order_path(order)
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
