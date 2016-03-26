require 'test_helper'

class StudioAdminViewsSpecificOrderTest < ActionDispatch::IntegrationTest
  test "studio admin sees only order photos associated with their studio" do
    category = create_category
    studio = create_studio
    other_studio = Studio.create(name:        "Other Studio",
                           description: "Other example description.",
                           status:      0,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )
    admin = create_and_login_studio_admin(studio)
    user = create_user
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

    order = create_order(user, photo)
    order2 = create_order(other_user, photo)

    order_photo3 = OrderPhoto.create(photo_id: photo2.id)
    order2.order_photos << order_photo3


    visit admin_orders_path(studio)
    click_on order2.id
    assert_equal admin_order_path(studio, order2), current_path
    assert page.has_content?(order2.id)
    assert page.has_content?(order2.placed_at)
    assert page.has_content?(other_user.email)
    assert page.has_content?(photo.name)
    refute page.has_content?(photo2.name)
    assert page.has_content?("$1,000.00")
  end
end
