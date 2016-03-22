require 'test_helper'

class VisitorMustLogInBeforeCheckingOutTest < ActionDispatch::IntegrationTest
  test "visitor prompted to log in before checking out" do
    user = User.create(email: "adrienne@example.com", password: "password", role: 0)
    business = Business.create(name: "Nature business", description: "Nature photos", status: 0)
    nature = Category.create(name: "Nature")
    #WHAT GOES IN THE IMAGE FIELDS?
    photo = nature.photos.create(name: "photo", desciption: "description", price: 2000, image: "placeholder", status: 0)
    business << photo

    visit categories_path
    click_on "Nature"
    click_on "photo"
    click_on "Add to Cart"

    visit cart_path
    click_on "Checkout"
    assert page.has_content?("You must log in or register to place an order.")

    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_on "Log In"
    assert_current_path("/cart")
    assert page.has_content?(photo.name)
  end
end
