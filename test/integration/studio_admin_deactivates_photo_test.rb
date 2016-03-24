require "test_helper"

class StudioAdminDeactivatesPhotoTest < ActionDispatch::IntegrationTest
  test "deactivates a photo" do
    category = create_category
    studio = create_studio
    admin = create_and_login_studio_admin(studio)
    photo = create_studio_photo(studio, category)

    visit photo_path(photo)
    assert page.has_content?("Add to Cart")
    click_on "Deactivate"

    assert_equal photo_path(photo), current_path
    assert page.has_content?("Photo Has Been Deactivated")
    refute page.has_content?("Add to Cart")

    within(".photo-show") do
      assert page.has_content?("Activate")
      refute page.has_content?("Deactivate")
    end

    visit category_path(category.slug)

    refute page.has_content?(photo.name)
  end
end
