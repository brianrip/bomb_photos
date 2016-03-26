require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  should validate_presence_of(:status)
  should belong_to(:user)
  should have_many(:order_photos)
  should have_many(:photos)
end
