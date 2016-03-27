require 'test_helper'

class PlatformAdminCanAddOrRemoveStudioAdminUsersTest < ActionDispatch::IntegrationTest
  test "platform admin updates a customer to become a studio admin" do
    studio = create_studio
    user = create_user
    create_and_login_platform_admin

    visit platform_admin_dashboard_path

    click_on "View/Edit"
    click_on "Manage studio administrative privileges"

    assert page.has_button? "Grant admin status for user #{user.id}"

    click_on "Grant admin status for user #{user.id}"
    assert page.has_content? "#{user.email} has been granted admin status!"

    assert page.has_button? "Revoke admin status for user #{user.id}"

    refute page.has_button? "Grant admin status for user #{user.id}"
  end

  test "platform admin removes a studio admin" do
    studio = create_studio
    admin = create_studio_admin(studio)
    create_and_login_platform_admin

    visit platform_admin_dashboard_path

    click_on "View/Edit"
    click_on "Manage studio administrative privileges"

    assert page.has_button? "Revoke admin status for user #{admin.id}"

    click_on "Revoke admin status for user #{admin.id}"
    assert page.has_content? "You have removed admin status for #{admin.email}"

    assert page.has_button? "Grant admin status for user #{admin.id}"
    refute page.has_button? "Revoke admin status for user #{admin.id}"
  end
end
