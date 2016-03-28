require 'test_helper'

class CustomerCanViewAPastOrderTest < ActionDispatch::IntegrationTest
  test "customer can see details of a past order" do
    category = create_category
    studio = create_studio
    user = create_user
    photo = create_studio_photo(studio, category)
    order = create_order(user, photo)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit orders_path
    click_on "Order: #{order.id}"
    assert page.has_content? order.id
    assert page.has_content? order.placed_at
    assert page.has_content? order.photos.first.name
    assert page.has_css?("img[src='#{order.photos.first.image}']")
    assert page.has_content?("$2.00")
  end
end
