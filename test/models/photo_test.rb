require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:description)
  should validate_presence_of(:price)
  should validate_numericality_of(:price).
    is_greater_than(0)
  should validate_presence_of(:image)
  should belong_to(:category)

  test "active is default true" do
    category = Category.create(name: "Nature")
    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0,
                          promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    photo = studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )
    assert photo.active
  end
end
