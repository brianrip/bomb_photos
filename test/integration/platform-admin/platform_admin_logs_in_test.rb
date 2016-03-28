require 'test_helper'

class PlatformAdminLogsInTest < ActionDispatch::IntegrationTest
  test "platform admin is redirected to platform admin dashboard when logging in" do
    studio = create_studio
    admin = studio.users.create(email:  "admin@example.com",
                                password: "password",
                                )
    admin.roles << customer_role
    admin.roles << studio_admin_role
    admin.roles << platform_admin_role

    visit login_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: "password"
    within(".login") do
      click_on "Log In"
    end

    assert_equal platform_admin_dashboard_path, current_path

  end
end
