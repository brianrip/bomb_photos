require "test_helper"

class RegisteredUserCannotSeeInactivePhotosTest < ActionDispatch::IntegrationTest
  test "they are hidden on the category show page" do
    studio   = create_studio
    category = create_category
    photo_1  = create_studio_photo(studio, category).update(name: "Photo 1")
    photo_2  = create_studio_photo(studio, category).update(name: "Photo 2")
    user     = create_user

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit category_path(category.slug)

    assert page.has_content?("Photo 1")
    assert page.has_content?("Photo 2")

    photo_2 = Photo.last.update(active: false)

    visit category_path(category.slug)

    assert page.has_content?("Photo 1")
    refute page.has_content?("Photo 2")
  end

  test "they are hidden on the studio show page" do
    studio   = create_studio
    category = create_category
    photo_1  = create_studio_photo(studio, category).update(name: "Photo 1")
    photo_2  = create_studio_photo(studio, category).update(name: "Photo 2")
    user     = create_user

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit studio_path(studio)

    assert page.has_content?("Photo 1")
    assert page.has_content?("Photo 2")

    photo_2 = Photo.last.update(active: false)

    visit studio_path(studio)

    assert page.has_content?("Photo 1")
    refute page.has_content?("Photo 2")
  end
end
