require 'test_helper'

class CustomerCannotViewPlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test "customer sees a 404 page when attempting to visit platform admin dashboard" do
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit platform_admin_dashboard_path

    assert page.has_content? "The page you were looking for doesn't exist"
  end
end
