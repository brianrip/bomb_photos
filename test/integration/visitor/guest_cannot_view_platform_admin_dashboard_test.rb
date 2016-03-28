require 'test_helper'

class GuestCannotViewPlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test "guest sees a 404 page when attempting to visit platform admin dashboard" do
    visit platform_admin_dashboard_path

    assert page.has_content? "The page you were looking for doesn't exist"
  end
end
