require 'test_helper'

class StudioAdminEditsStudio < ActionDispatch::IntegrationTest
  test "studio admin edits their own studio" do
    studio = create_studio
    create_and_login_studio_admin(studio)

    visit admin_dashboard_path

    click_on "Edit Studio"

    fill_in "Name", with: "Different Name"

    click_on "Update Studio"

    assert page.has_content?("Your studio has been updated!")
    assert page.has_content?("Different Name")
  end

  # test "studio admin must enter all fields" do
  # end

  # test "studio admin cannot edit another studio" do
  # end
end
