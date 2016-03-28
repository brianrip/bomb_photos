require "test_helper"

class AdminForInactiveStudioCannotActivatePhotoTest < ActionDispatch::IntegrationTest
  test "attemps to activate a photo and gets a 404" do
    category = create_category
    studio   = create_studio
    photo    = create_studio_photo(studio, category)
    admin    = create_and_login_studio_admin(studio)

    studio.update_attributes(status: 1)
    photo.update_attributes(active: false)

    visit photo_path(photo)

    click_on "Activate"

    assert_equal photo_path(photo), current_path
    assert page.has_content?("That action is prohibited.")
  end
end
