require "test_helper"

class StudioAdminCanCreatePhotoTest < ActionDispatch::IntegrationTest
  test "create photo with valid attributes" do
    Category.create(name: "A Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    admin = studio.users.create(email:  "admin@example.com",
                                password: "password",
                                role:     1
    )

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_dashboard_path
    click_on "Add New Photo"

    assert_equal new_admin_photo_path, current_path

    fill_in "Name",        with: "Example Name"
    fill_in "Description", with: "Example Description"
    fill_in "Price",       with: "9.99"
    select "A Category", from: "photo[category_id]"
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

    assert page.has_content?("Your Photo Has Been Created")

    visit new_admin_photo_path

    fill_in "Name",        with: "Example Name"
    fill_in "Description", with: "Example Description"
    fill_in "Price",       with: "10"
    select "A Category", from: "photo[category_id]"
    attach_file "Image", "test/asset_tests/photos/sample_photo.jpg"
    click_on "Create Photo"

    assert page.has_content?("Your Photo Has Been Created")

    visit photo_path(Photo.last)

    assert page.has_content?("$10.00")
  end
end
