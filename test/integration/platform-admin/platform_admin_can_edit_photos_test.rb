require 'test_helper'

class PlatformAdminCanEditPhotosTest < ActionDispatch::IntegrationTest
  test "platform admin can edit photos" do
    studio         = create_studio
    category       = create_category
    other_category = create_category.update(name: "Other Category")
    photo          = create_studio_photo(studio, category)
    admin          = create_and_login_platform_admin

    visit photo_path(photo)

    click_on "Edit"

    assert_equal edit_admin_photo_path(studio, photo), current_path

    fill_in "Name",        with: "New Name"
    fill_in "Description", with: "New Description"
    fill_in "Price",       with: "8.99"
    select "Other Category", from: "photo[category_id]"
    attach_file "Image", "test/asset_tests/photos/sample_photo.jpg"

    click_on "Update Photo"

    assert_equal photo_path(photo), current_path
    assert page.has_content?("Photo Has Been Updated")

    within(".photo-show") do
      assert page.has_content?("New Name")
      assert page.has_content?("New Description")
      assert page.has_content?("Other Category")
      assert page.has_content?("$8.99")
    end
  end
end
