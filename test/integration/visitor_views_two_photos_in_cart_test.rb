require 'test_helper'

class VisitorViewsTwoPhotosInCartTest < ActionDispatch::IntegrationTest
  test "two photos are present in cart view" do
    category = Category.create(name: "Example Category")
    Category.create(name: "Other Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

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
    visit category_path(category.name)

    click_on photo1.name
    click_on "Add to Cart"

    visit category_path(category.name)

    click_on photo2.name
    click_on "Add to Cart"

    within(".shopping_cart") do
      click_on "Cart"
    end

    assert page.has_link? photo1.name
    assert page.has_link? category.name
    assert page.has_content? photo1.price

    assert page.has_link? photo2.name
    assert page.has_link? category.name
    assert page.has_content? photo2.price

    assert page.has_content? (photo1.price + photo2.price)

    assert page.has_link? "Continue shopping"
    assert page.has_content? "Checkout"
  end
end
