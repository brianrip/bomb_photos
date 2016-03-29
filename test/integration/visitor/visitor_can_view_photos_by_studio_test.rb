require 'test_helper'

class VisitorCanViewPhotosByStudioTest < ActionDispatch::IntegrationTest
  test "visitor sees all photos associated with a studio" do
    category = create_category

    studio1 = create_studio
    studio2 = Studio.create(name:        "Studio2",
                            description: "Example description2.",
                            status:      0,
                            promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    photo1 = studio1.photos.create(name:        "Example Name1",
                                   description: "Example Description1",
                                   image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                   price:       999,
                                   category_id: category.id
    )
    photo2 = studio1.photos.create(name:        "Example Name2",
                                   description: "Example Description2",
                                   image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                   price:       999,
                                   category_id: category.id
    )
    photo3 = studio2.photos.create(name:        "Example Name3",
                                   description: "Example Description3",
                                   image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                   price:       999,
                                   category_id: category.id
    )

    visit root_path
    click_on "Shop"
    click_on "By Studio"

    assert page.has_link? studio1.name
    assert page.has_link? studio2.name

    click_on studio1.name

    assert page.has_content? photo1.name
    assert page.has_content? photo2.name
    refute page.has_content? photo3.name
  end
end
