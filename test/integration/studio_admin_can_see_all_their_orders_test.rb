require 'test_helper'

class StudioAdminSeesAllTheirOrdersTest < ActionDispatch::IntegrationTest
  test "studio admin can see all orders" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
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
    other_user = User.create(email:  "otherexample@eample.com",
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

    op2 = OrderPhoto.create(photo_id: photo.id)
    order2 = other_user.orders.create(total_price: 200)
    order2.order_photos << op2

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "View Orders"
# save_and_open_page
    assert page.has_content?(order.id)
    assert page.has_content?(order.total_price)
    assert page.has_content?(order.created_at.to_date)
    assert page.has_content?(order2.id)
    assert page.has_content?(order2.total_price)
    assert page.has_content?(order2.created_at.to_date)
  end
end
