require 'test_helper'

class StudioAdminViewsSpecificOrderTest < ActionDispatch::IntegrationTest
  test "studio admin sees only order photos associated with their studio" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    other_studio = Studio.create(name:        "Other Studio",
                           description: "Other example description.",
                           status:      0
    )

    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                role:     1
    )

    user = studio.users.create(email:  "example@eample.com",
                        password: "password",
                        role:     0
    )
    other_user = other_studio.users.create(email:  "otherexample@eample.com",
                              password: "password",
                              role:     0
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       1000,
                                 category_id: category.id
    )

    photo2 = other_studio.photos.create(name:        "Example2 Name",
                                 description: "Example2 Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       1000,
                                 category_id: category.id
    )

    op = OrderPhoto.create(photo_id: photo.id)
    order = user.orders.create(total_price: 2000)
    order.order_photos << op

    op3 = OrderPhoto.create(photo_id: photo2.id)
    op2 = OrderPhoto.create(photo_id: photo.id)
    order2 = other_user.orders.create(total_price: 2000)
    order2.order_photos << op2
    order2.order_photos << op3

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_orders_path
    click_on order2.id
    assert_equal admin_order_path(order2), current_path
    assert page.has_content?(order2.id)
    assert page.has_content?(order2.created_at)
    assert page.has_content?(other_user.email)
    assert page.has_content?(photo.name)
    refute page.has_content?(photo2.name)
    assert page.has_content?("$1,000.00")
  end
end
