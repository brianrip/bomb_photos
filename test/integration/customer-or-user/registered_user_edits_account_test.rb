require 'test_helper'

class RegisteredUserEditsAccountTest < ActionDispatch::IntegrationTest
  test "user edits email address" do
    visit '/'
    click_on "Sign Up"
    fill_in "Email", with: "brianthemountain@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Register"

    click_on "Edit User Info"

    fill_in "Email", with: "scott@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Update"

    assert page.has_content?("Your account has been updated!")
    assert page.has_content?("scott@example.com")
    assert_equal "scott@example.com", User.last.email
  end
end
