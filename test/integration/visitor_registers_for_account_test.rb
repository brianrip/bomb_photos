require 'test_helper'

class VisitorRegistersForAccountTest < ActionDispatch::IntegrationTest
  test "visitor registers for an account" do
    visit '/'
    click_on "Sign Up"
    fill_in "Email", with: "adrienne@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Register"

    assert_equal dashboard_path, current_path
    assert page.has_content?("Thank you for creating an account!")
    assert page.has_content?("adrienne@example.com")
    assert page.has_content?("My Orders")
    assert page.has_content?("Edit User Info")
  end
end
