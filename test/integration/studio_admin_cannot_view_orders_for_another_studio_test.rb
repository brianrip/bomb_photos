require 'test_helper'

class StudioAdminCanOnlyViewTheirOrdersTest < ActionDispatch::IntegrationTest
  test "studio admin tries to view an order that is not theirs and can't" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )
    other_studio = Studio.create(name:        "Other Studio",
                                description:  "Example description2.",
                                status:      0
    )

    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                role:     1
    )

    user = User.create(email:  "example@eample.com",
                        password: "password",
                        role:     0
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    other_photo = other_studio.photos.create(name:        "Example Name 2",
                                             description: "Example Description2",
                                             image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                             price:       999,
                                             category_id: category.id
    )

    op = OrderPhoto.create(photo_id: photo.id)
    order = user.orders.create(total_price: 200)
    order.order_photos << op

    op2 = OrderPhoto.create(photo_id: other_photo.id)
    order2 = user.orders.create(total_price: 200)
    order2.order_photos << op2

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_orders_path
    assert page.has_content?(order.id)
    refute page.has_content?(order2.id)
  end
end
