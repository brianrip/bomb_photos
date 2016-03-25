require 'test_helper'

class VisitorMustLogInBeforeCheckingOutTest < ActionDispatch::IntegrationTest
  test "visitor prompted to log in before checking out" do
    category = create_category
    studio = create_studio
    user = create_user
    photo = create_studio_photo(studio, category)

    visit categories_path
    click_on "Example Category"
    click_on "Example Name"
    click_on "Add to Cart"

    visit cart_path
    click_on "Checkout"
    assert page.has_content?("You must log in or register to place an order.")

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    within(".login") do
      click_on "Log In"
    end
    assert_equal cart_path, current_path
    assert page.has_content?(photo.name)
  end
end
