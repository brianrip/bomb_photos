require 'test_helper'

class OrderPhotoTest < ActiveSupport::TestCase
  should validate_presence_of(:quantity)
  should validate_presence_of(:subtotal)
  should belong_to(:order)
  should belong_to(:gif)
end
