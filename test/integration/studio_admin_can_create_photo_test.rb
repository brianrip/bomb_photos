require "test_helper"

class StudioAdminCanCreatePhotoTest < ActionDispatch::IntegrationTest
  test "create photo with valid attributes" do
    category = create_category
    studio = create_studio
    admin = create_and_login_studio_admin(studio)

    visit admin_path(studio)
    click_on "Add New Photo"

    assert_equal new_admin_photo_path(studio), current_path

    fill_in "Name",        with: "Example Name"
    fill_in "Description", with: "Example Description"
    fill_in "Price",       with: "9.99"
    select "Example Category", from: "photo[category_id]"
    attach_file "Image", "test/asset_tests/photos/sample_photo.jpg"
    click_on "Create Photo"

    photo = Photo.all.last

    assert_equal photo_path(photo), current_path
    within(".photo-show") do
      assert page.has_content?(photo.name)
      assert page.has_content?(photo.description)
      assert page.has_content?(photo.studio.name)
      assert page.has_content?(photo.category.name)
    end

    # assert page.has_content?("$9.99")
    assert page.has_content?("Your Photo Has Been Created")
  end
end
