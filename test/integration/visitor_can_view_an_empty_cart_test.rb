require 'test_helper'

class VisitorCanViewAnEmptyCartTest < ActionDispatch::IntegrationTest
  test "visitor sees an empty cart" do
    visit root_path
    click_on "Cart(0)"
    assert page.has_content? "Your cart is empty"
  end
end
