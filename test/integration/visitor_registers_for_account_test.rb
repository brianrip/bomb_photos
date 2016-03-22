require 'test_helper'

class VisitorRegistersForAccountTest < ActionDispatch::IntegrationTest
  test "visitor registers for an account" do
    visit '/'
    click_on "Sign Up"
    fill_in "email", with: "adrienne@example.com"
    fill_in "password", with: "password"
    fill_in "password confirmation", with: "password"
    click_on "Register"

    assert page.has_content?("Thank you for creating an account!")
    assert page.has_content?("adrienne@example.com")
    assert page.has_content?("Edit Account Information")
    assert page.has_content?("View All Orders")
    assert page.has_content?("View All Photos")
  end
end
