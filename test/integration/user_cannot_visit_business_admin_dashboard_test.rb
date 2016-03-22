require 'test_helper'

class UserCannotVisitBusinessAdminDashboardTest < ActionDispatch::IntegrationTest
  test "user sees 404 page when trying to access business admin dashboard" do
    visit admin_dashboard_path
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end