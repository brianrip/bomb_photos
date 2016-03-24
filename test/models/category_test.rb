require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  should have_many(:photos)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
end
