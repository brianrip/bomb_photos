require 'test_helper'

class GuestCannotViewCustomerOrdersTest < ActionDispatch::IntegrationTest
  test "unauthorized attempt to see order renders error page" do
    category = create_category
    studio = create_studio
    user = create_user
    photo = create_studio_photo(studio, category)
    order = create_order(user, photo)

    visit order_path(order.id)
    assert page.has_content? "The page you were looking for doesn't exist."
  end
end
