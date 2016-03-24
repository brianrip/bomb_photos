require "test_helper"

class VisitorViewsPhotosByCategoryTest < ActionDispatch::IntegrationTest
  test "sees photos by category" do
    category_1 = Category.create(name: "Example Category 1")
    category_2 = Category.create(name: "Example Category 2")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    user = studio.users.create(email:    "admin@example.com",
                               password: "password",
                               role:     0
    )

    photo_1 = studio.photos.create(name:      "Example Photo 1",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category_1.id
    )

    photo_2 = studio.photos.create(name:      "Example Photo 2",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category_2.id
    )

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit root_path

    click_on "Example Category 1"

    assert_equal category_path(category_1.slug), current_path

    assert page.has_content?("Example Category 1")
    refute page.has_content?("Example Category 2")
    assert page.has_content?("Example Photo 1")
    refute page.has_content?("Example Photo 2")

    visit root_path

    click_on "Example Category 2"

    assert_equal category_path(category_2.slug), current_path

    assert page.has_content?("Example Category 2")
    refute page.has_content?("Example Category 1")
    assert page.has_content?("Example Photo 2")
    refute page.has_content?("Example Photo 1")
  end
end
