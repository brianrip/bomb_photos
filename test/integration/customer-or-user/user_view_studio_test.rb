require "test_helper"

class UserViewStudioTest < ActionDispatch::IntegrationTest
  test "they see the studio information" do
    category = create_category
    studio = create_studio
    photo1 = studio.photos.create(name:        "Example Name1",
                                   description: "Example Description1",
                                   image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                   price:       999,
                                   category_id: category.id
    )
    photo2 = studio.photos.create(name:        "Example Name2",
                                   description: "Example Description2",
                                   image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                   price:       999,
                                   category_id: category.id
    )

    visit "/#{studio.slug}"

    assert page.has_content? studio.name
    assert page.has_content? studio.description
    assert page.has_content? photo1.name
    assert page.has_content? photo2.name
  end
end
