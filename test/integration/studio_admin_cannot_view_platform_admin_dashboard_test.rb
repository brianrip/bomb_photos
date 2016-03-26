require 'test_helper'

class StudioAdminCannotViewPlatformAdminDashboardTest < ActionDispatch::IntegrationTest
  test "studio admin sees a 404 page when attempting to visit platform admin dashboard" do
    studio = create_studio
    create_and_login_studio_admin(studio)

    visit platform_admin_dashboard_path

    assert page.has_content? "The page you were looking for doesn't exist"
  end
end
