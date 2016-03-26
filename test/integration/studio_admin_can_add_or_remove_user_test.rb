git require 'test_helper'

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

    # save_and_open_page
    assert page.has_link? "Revoke admin status for user #{admin.id}"
    refute page.has_link? "Grant admin status for user #{user.id}"
  end
end
