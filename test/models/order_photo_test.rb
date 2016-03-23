require 'test_helper'

class OrderPhotoTest < ActiveSupport::TestCase
  should belong_to(:order)
  should belong_to(:photo)
end
