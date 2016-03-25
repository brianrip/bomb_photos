require 'test_helper'

class StudioAdminSeesAllTheirOrdersTest < ActionDispatch::IntegrationTest
  test "studio admin can see all orders" do
    category = create_category
    studio = create_studio
    admin = create_and_login_studio_admin(studio)
    user = create_user
    other_user = User.create(email:  "otherexample@eample.com",
                              password: "password",
                              role:     0
    )
    photo = create_studio_photo(studio, category)

    order = create_order(user, photo)
    order2 = create_order(other_user, photo)

    visit admin_path(studio)
    click_on "View Orders"

    assert page.has_content?(order.id)
    assert page.has_content?(order.total_price)
    assert page.has_content?(order.placed_at)
    assert page.has_content?(order2.id)
    assert page.has_content?(order2.total_price)
    assert page.has_content?(order2.placed_at)
  end
end
