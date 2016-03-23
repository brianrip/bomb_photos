require 'test_helper'

class VisitorCanRemovePhotoFromCartTest < ActionDispatch::IntegrationTest
  test "visitor sees cart without removed photo" do
    category = Category.create(name: "Example Category")
    Category.create(name: "Other Category")

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

    photo2 = studio.photos.create(name:        "Photo 2",
                                 description: "Example Description 2",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    visit categories_path

    click_on category.name
    click_on photo.name
    click_on "Add to Cart"
    visit categories_path

    click_on category.name
    click_on photo2.name
    click_on "Add to Cart"

    within(".shopping-cart") do
      click_on "Cart"
    end

    assert page.has_content? photo.name
    assert page.has_content? photo2.name
    assert page.has_content? "Total: 2"

    within first("#photo-info", minimum: 1) do
      click_link("Remove")
    end

    refute page.has_content? photo.name
    assert page.has_content? photo2.name
    assert page.has_content? "Total: 1"
  end
end
