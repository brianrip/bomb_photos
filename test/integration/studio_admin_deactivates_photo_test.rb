require "test_helper"

class StudioAdminDeactivatesPhotoTest < ActionDispatch::IntegrationTest
  test "deactivates a photo" do
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
    click_on "Deactivate"

    assert_template "admin/photos#index"
    assert page.has_content?("Photo Has Been Deactivated")

    within(".photo")
      assert page.has_content?("Deactivated")
    end

    visit photos_path(category)

    refute page.has_content?(#####)
  end
end
