require 'test_helper'

class VisitorCanViewAnEmptyCartTest < ActionDispatch::IntegrationTest
  test "visitor sees an empty cart" do
    visit root_path
    click_on "Cart"
    assert page.has_content? "Your cart is empty"
  end
end
