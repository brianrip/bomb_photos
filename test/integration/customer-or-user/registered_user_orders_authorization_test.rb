require 'test_helper'

class RegisteredUserOrdersAuthorizationTest < ActionDispatch::IntegrationTest
  test "user who tries to view other user's order cannot" do
    category = create_category
    studio = create_studio
    user = create_user
    other_user = studio.users.create(email:  "other_user@example.com",
                                     password: "password",
                                     )
    other_user.roles << customer_role
    photo = create_studio_photo(studio, category)
    order = create_order(other_user, photo)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit order_path(order)
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
