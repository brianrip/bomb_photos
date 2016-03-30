require 'test_helper'

class StudioAdminCanViewSalesDataTest < ActionDispatch::IntegrationTest
  test "admin can see their studio revenue and most profitable items" do
    studio = create_studio
    category = create_category
    user = create_user
    photo1 = create_studio_photo(studio, category, 3005)
    photo2 = create_studio_photo(studio, category, 2005)
    photo3 = create_studio_photo(studio, category, 1005)
    order1 = create_order(user, photo1)
    order2 = create_order(user, photo2)
    order3 = create_order(user, photo3)
    admin = create_and_login_studio_admin(studio)

    visit admin_path(admin)

    click_on "Studio analytics"

    assert page.has_content? "Revenue for #{studio.name}: $60.15"
    assert page.has_content? "Top selling photo: #{photo1.name}"
  end
end
