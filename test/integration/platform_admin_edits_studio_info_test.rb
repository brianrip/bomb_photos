require 'test_helper'

class PlatformAdminEditsStudioInfoTest < ActionDispatch::IntegrationTest
  test "platform admin can edit their studio info" do
    studio = create_studio
    admin  = create_and_login_studio_platform_admin(studio)

    visit admin_path(studio)

    click_on "Edit Studio"
    fill_in "Name", with: "Updated Name"

    click_on "Update Studio"

    assert page.has_content?("Your studio has been updated!")
    assert page.has_content?("Updated Name")
  end

  test "platform admin can edit another studios info" do
    studio = create_studio
    admin  = create_and_login_platform_admin

    visit admin_path(studio)
    click_on "Edit Studio"

    fill_in "Name", with: "Different Updated Name"

    click_on "Update Studio"

    assert page.has_content?("Your studio has been updated!")
    assert page.has_content?("Different Updated Name")
  end
end
