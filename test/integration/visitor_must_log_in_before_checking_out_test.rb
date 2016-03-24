require 'test_helper'

class VisitorMustLogInBeforeCheckingOutTest < ActionDispatch::IntegrationTest
  test "visitor prompted to log in before checking out" do
    category = Category.create(name: "Example Category")

    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    user = User.create(email:  "user@example.com",
                                password: "password",
                                role:     0
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    visit categories_path
    click_on "Example Category"
    click_on "Example Name"
    click_on "Add to Cart"

    visit cart_path
    click_on "Checkout"
    assert page.has_content?("You must log in or register to place an order.")

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    within(".login") do
      click_on "Log In"
    end
    assert_equal cart_path, current_path
    assert page.has_content?(photo.name)
  end
end
