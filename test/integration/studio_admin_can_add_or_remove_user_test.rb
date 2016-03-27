require 'test_helper'

class StudioAdminCanAddOrRemoveUserTest < ActionDispatch::IntegrationTest
  test "studio admin changes status of standard user to appear as studio admin" do
    category = create_category
    studio = create_studio
    admin = create_studio_admin(studio)
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_path(studio)
    click_on "Manage studio administrative privileges"
    assert page.has_link? "Revoke admin status for user #{admin.id}"
    assert page.has_link? "Grant admin status for user #{user.id}"

    click_on "Grant admin status for user #{user.id}"
    assert page.has_content? "#{user.email} has been granted admin status!"

    assert page.has_link? "Revoke admin status for user #{admin.id}"
    refute page.has_link? "Grant admin status for user #{user.id}"
  end

  test "studio admin removes a fellow studio admin but not self" do
    category = create_category
    studio = create_studio
    admin = create_studio_admin(studio)
    admin2 = create_studio_admin(studio)

    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_path(studio)
    click_on "Manage studio administrative privileges"

    assert page.has_link? "Revoke admin status for user #{admin2.id}"
    assert page.has_link? "Grant admin status for user #{user.id}"

    click_on "Revoke admin status for user #{admin.id}"
    assert page.has_content?"You cannot remove yourself at this time, please contact Bomb Photos to perform this action."

    click_on "Revoke admin status for user #{admin2.id}"
    assert page.has_content? "You have removed admin status for #{admin2.email}"
    assert page.has_link? "Grant admin status for user #{user.id}"
    assert page.has_link? "Grant admin status for user #{admin2.id}"
    refute page.has_link? "Revoke admin status for user #{admin2.id}"
  end
end
