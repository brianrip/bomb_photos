require 'test_helper'

class VisitorViewsTwoPhotosInCartTest < ActionDispatch::IntegrationTest
  test "two photos are present in cart view" do
    category = create_category
    Category.create(name: "Other Category")
    studio = create_studio
    photo1 = create_studio_photo(studio, category)
    photo2 = studio.photos.create(name:        "Example Name2",
                                 description: "Example Description2",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    visit category_path(category.slug)

    click_on photo1.name
    click_on "Add to Cart"

    visit category_path(category.slug)

    click_on photo2.name
    click_on "Add to Cart"

    click_on "Cart(2)"

    assert page.has_link? photo1.name
    assert page.has_link? category.name
    assert page.has_content? "$9.99"

    assert page.has_link? photo2.name
    assert page.has_link? category.name
    assert page.has_content? "$9.99"
    assert page.has_content? ("19.98")

    assert page.has_link? "Continue Shopping"
    assert page.has_content? "Checkout"
  end
end
