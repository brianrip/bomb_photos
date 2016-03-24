require 'test_helper'

class VisitorCanAddPhotosToCartTest < ActionDispatch::IntegrationTest
  test "visitor sees a cart with multiple items" do

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
    assert page.has_content? "Photo has been added to cart"
    visit categories_path

    assert page.has_content? "Cart(1)"

    visit category_path(category.slug)

    click_on photo2.name
    click_on "Add to Cart"

    assert page.has_content? "Photo has been added to cart"
    assert page.has_content? "Cart(2)"
  end
end
