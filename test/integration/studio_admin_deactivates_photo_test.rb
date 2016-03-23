require "test_helper"

class StudioAdminDeactivatesPhotoTest < ActionDispatch::IntegrationTest
  test "deactivates a photo" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    admin = studio.users.create(email:  "admin@eample.com",
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
