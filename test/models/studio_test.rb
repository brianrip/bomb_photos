require 'test_helper'

class StudioTest < ActiveSupport::TestCase
  should validate_presence_of(:promo_image)
  should validate_presence_of(:name)
  should validate_presence_of(:description)
end
