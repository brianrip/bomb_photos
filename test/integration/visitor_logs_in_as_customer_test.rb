# As a registered customer,
# when I visit root,
# I should not see "log out" on header,
# and I should not see my username/email on header,
# and I should see "log in" on header,
# and when I click "log in",
# and I fill in my username/email,
# and I click "log in",
# then I should see my dashboard,
# and I should see "log out" on my header,
# and I should not see "log in" on my header,
# and I should see my username on my header.
require 'test_helper'

class VisitorLogsInAsCustomer < ActionDispatch::IntegrationTest

  test "visitor logs in" do
    user = User.create(email: "adrienne@example.com", password: password, role: 0)
    visit '/'
    refute page.has_content?("Log Out")
    refute page.has_content?(user.email)
    assert page.has_content?("Log In")

    click_on "Log In"

    fill_in "email", with: user.email
    fill_in "password", with: "password"

    click_on "Log In"

    assert_current_path('/dashboard')

    assert page.has_content?("Log Out")
    refute page.has_content?("Log In")
    assert page.has_content?(user.email)
  end
end
