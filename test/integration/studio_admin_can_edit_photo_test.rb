require "test_helper"

class StudioAdminCanEditPhotoTest < ActionDispatch::IntegrationTest
  test "edit photo with valid attributes" do
    category = create_category
    Category.create(name: "Other Category")
    studio = create_studio
    admin = create_and_login_studio_admin(studio)
    photo = create_studio_photo(studio, category)

    visit photo_path(photo)
    click_on "Edit"
    assert_equal edit_admin_photo_path(photo), current_path

    fill_in "Name",        with: "New Name"
    fill_in "Description", with: "New Description"
    fill_in "Price",       with: "999"
    select "Other Category", from: "photo[category_id]"
    attach_file "Image", "test/asset_tests/photos/sample_photo.jpg"

    click_on "Update Photo"
    assert_equal photo_path(photo), current_path
    within(".photo-show") do
      assert page.has_content?("New Name")
      assert page.has_content?("New Description")
      assert page.has_content?("Other Category")
    end

    assert page.has_content?("Photo Has Been Updated")
  end
end
