require 'test_helper'

class UserAppliesForNewStudioTest < ActionDispatch::IntegrationTest
  test "registered user applies for studio" do
    user = User.create(email:  "user@example.com",
                                password: "password",
                                role:     0
    )

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path

    click_on "Sign up here!"
    fill_in "Name", with: "Studio name"
    fill_in "Description", with: "Studio description"
    attach_file "Promo image", "test/asset_tests/photos/sample_photo.jpg"
    click_on "Create Studio"

    assert_equal dashboard_path, current_path
    assert page.has_content?("Application submitted!")
    assert page.has_content?("You have applied for a studio on Bomb Photos. Your application is pending. View or edit your application here")
    refute page.has_content?("Want to sell photos on our site?")
  end

  test "user must fill in all fields" do
    user = User.create(email:  "user@example.com",
                                password: "password",
                                role:     0
    )

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path

    click_on "Sign up here!"
    fill_in "Name", with: "Studio name"
    click_on "Create Studio"

    assert page.has_content?("You must provide all information.")
    assert page.has_content?("Promo image")
  end
end
