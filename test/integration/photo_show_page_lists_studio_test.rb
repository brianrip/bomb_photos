require 'test_helper'

class PhotoShowPageListsStudioTest < ActionDispatch::IntegrationTest
  test "visitor sees studio on photo show page" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    visit photo_path(photo)

    assert page.has_content? studio.name
  end
end
