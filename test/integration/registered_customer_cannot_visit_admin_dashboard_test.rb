require 'test_helper'

class RegisteredCustomerCannotVisitAdminDashboardTest < ActionDispatch::IntegrationTest
  test "logged in user sees 404 page when visiting businessadmin dashboard" do
    studio = create_studio
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_path(studio)

    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
