require 'test_helper'

class VisitorLogsInAsCustomer < ActionDispatch::IntegrationTest

  test "visitor logs in and out" do
    user = User.create(email: "adrienne@example.com", password: "password")
    user.roles << customer_role
    visit '/'
    refute page.has_content?("Log Out")
    refute page.has_content?(user.email)
    assert page.has_content?("Log In")

    click_on "Log In"

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"

    within(".login") do
      click_on "Log In"
    end

    assert_current_path('/dashboard')

    assert page.has_content?("Log Out")
    refute page.has_content?("Log In")
    assert page.has_content?(user.email)

    click_on "Log Out"
    refute page.has_content?("Log Out")
    assert page.has_content?("Log In")
    refute page.has_content?(user.email)
  end
end
