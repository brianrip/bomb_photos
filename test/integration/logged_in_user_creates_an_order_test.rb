require 'test_helper'

class LoggedInUserCreatesAnOrderTest < ActionDispatch::IntegrationTest

  test "user can see order summary" do
    skip
    category = create_category
    studio = create_studio
    user = create_user
    photo = create_studio_photo(studio, category)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit root_path

    click_on "Example Category"
    click_on "Example Name"
    click_on "Add to Cart"

    visit cart_path

    click_on "Checkout"

    assert_equal new_order_path, current_path

    assert page.has_content? "Please complete your order"
    assert page.has_content? photo.name
    assert page.has_content? "$9.99"
    assert page.has_css?("img[src='#{photo.image}']")
    assert page.has_content? "Total: $9.99"
    # save_and_open_page

    click_on "Pay with Card"

    assert page.has_content?("Your order is complete")
    assert page.has_content? order.total_price
    assert page.has_content? order.created_at
    # assert page.has_link? "all photos"
    # assert page.has_link? "all orders"
  end
end
