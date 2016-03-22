require "test_helper"

class StudioAdminCanEditPhotoTest < ActionDispatch::IntegrationTest
  test "edit photo with valid attributes" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      "Approved"
    )

    admin = studio.users.create(username:  "admin",
                                 password: "password",
                                 role:     1
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image_url:   ####,
                                 price:       999
    )

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_studio_photo_path(photo)
    click_on "Edit"

    assert_template "admin/photos#edit"

    fill_in "Name",        with: "New Name"
    fill_in "Description", with: "New Description"
    fill_in "Price",       with: "999"
    find('#categorySelect').find(:xpath, "Example Category").select_option
    fill_in  "Image URL",   with: #whereshouldthiscomefrom?
    click_on "Update Photo"

    assert_template "admin/photos#index"
    within(".photo")
      assert page.has_content?(###)
    end
    assert page.has_content("Your Photo Has Been Updated")
  end
