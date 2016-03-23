require 'test_helper'

class CustomerCanViewMultiplePastOrdersTest < ActionDispatch::IntegrationTest
  test "customer can see details of a past order" do

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
                                 category_id: category.id
    )

    photo2 = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    op = OrderPhoto.create(photo_id: photo.id)
    op2 = OrderPhoto.create(photo_id: photo2.id)
    order1 = user.orders.create(total_price: 999)
    order2 = user.orders.create(total_price: 999)
    order1.order_photos << op
    order2.order_photos << op2

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path
    click_on "My Orders"

    assert page.has_content? order1.id
    assert page.has_content? order1.created_at
    # assert page.has_content? order1.total
    assert page.has_content? order2.id
    assert page.has_content? order2.created_at
    # assert page.has_content? order2.total
  end
end
