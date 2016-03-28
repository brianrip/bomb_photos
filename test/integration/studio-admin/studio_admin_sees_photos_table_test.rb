require 'test_helper'

class StudioAdminSeesPhotosTableTest < ActionDispatch::IntegrationTest
  test "studio admin sees table of studios photos" do
    category = create_category
    studio   = create_studio
    photo_1  = create_studio_photo(studio, category).update_attributes(name: "Photo 1")
    photo_2  = create_studio_photo(studio, category).update_attributes(name: "Photo 2")
    create_and_login_studio_admin(studio)

    visit admin_path(studio)
    click_on "Manage Photos"

    within("table") do
      assert page.has_link?("Photo 1")
      assert page.has_link?("Photo 2")
      assert page.has_content?("Edit")
      assert page.has_content?("Deactivate")
    end
  end

end
