require 'test_helper'

class StudioAdminCanOnlyViewTheirOrdersTest < ActionDispatch::IntegrationTest
  test "studio admin tries to view an order that is not theirs and can't" do
    category = create_category
    studio = create_studio
    admin = create_and_login_studio_admin(studio)
    user = create_user
    photo = create_studio_photo(studio, category)

    other_studio = Studio.create(name:        "Other Studio",
    description:  "Example description2.",
    status:      0,
    promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"

    )
    other_photo = other_studio.photos.create(name:        "Example Name 2",
                                             description: "Example Description2",
                                             image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                             price:       999,
                                             category_id: category.id
                                             )

    order = create_order(user, photo)
    order2 = create_order(user, other_photo)


    visit admin_orders_path
    assert page.has_content?(order.id)
    refute page.has_content?(order2.id)
  end
end
