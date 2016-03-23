require "test_helper"

class StudioAdminCanEditPhotoTest < ActionDispatch::IntegrationTest
  test "edit photo with valid attributes" do
    category = Category.create(name: "Example Category")
    Category.create(name: "Other Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    admin = studio.users.create(email:  "admin",
                                password: "password",
                                role:     1
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

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
