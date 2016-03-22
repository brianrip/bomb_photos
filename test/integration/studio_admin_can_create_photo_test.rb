require "test_helper"

class StudioAdminCanCreatePhotoTest < ActionDispatch::IntegrationTest
  test "create photo with valid attributes" do
    Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      "Approved"
    )

    admin = studio.users.create(username:  "admin",
                                 password: "password",
                                 role:     1
    )

    ApplicationController.any_instance.stubs(:current_user).returns(users(:admin))

    visit studio_admin_dashboard_path
    click_on "Add New Photo"

    assert_template "admin/photos#new"

    fill_in "Name",        with: "Example Name"
    fill_in "Description", with: "Example Description"
    fill_in "Price",       with: "999"
    find('#categorySelect').find(:xpath, "Example Category").select_option
    fill_in  "Image URL",   with: #whereshouldthiscomefrom?
    click_on "Create Photo"

    assert_template "admin/photos#new"
    within(".photo")
      assert page.has_content?(###)
    end
    assert page.has_content("Your Photo Has Been Created")
  end
