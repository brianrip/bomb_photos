require "test_helper"

class StudioAdminActivatesPhotoTest < ActionDispatch::IntegrationTest
  test "activates a photo" do
    category = create_category
    studio = create_studio
    admin = create_and_login_studio_admin(studio)
    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id,
                                 active:      false
    )
    visit photo_path(photo)

    refute page.has_content?("Add to Cart")

    click_on "Activate"

    assert_equal photo_path(photo), current_path
    assert page.has_content?("Photo Has Been Activated")
    assert page.has_content?("Add to Cart")

    within(".photo-show") do
      refute page.has_content?("Activate")
      assert page.has_content?("Deactivate")
    end

    visit category_path(category.slug)

    assert page.has_content?(photo.name)
  end
end
