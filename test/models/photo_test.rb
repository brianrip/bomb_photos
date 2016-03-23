require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:description)
  should validate_presence_of(:price)
  should validate_numericality_of(:price).
    is_greater_than(0)
  should validate_presence_of(:image)
  should have_many(:tags).through(:gif_tags)

  test "retired is default false" do
    gif = create(:gif)

    assert_equal false, gif.retired
  end
end
