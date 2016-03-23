require 'test_helper'

class RegisteredCustomerCannotVisitAdminDashboardTest < ActionDispatch::IntegrationTest
  test "logged in user sees 404 page when visiting businessadmin dashboard" do
    user = User.create(email: "adrienne@example.com", password: "password", role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_dashboard_path

    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
