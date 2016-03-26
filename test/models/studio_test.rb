require 'test_helper'

class StudioTest < ActiveSupport::TestCase
  should validate_presence_of(:promo_image)
  should validate_presence_of(:name)
  should validate_presence_of(:description)

  test "revenue returns studio revenue" do
    category = create_category
    user = create_user
    studio = create_studio
    photo = create_studio_photo(studio, category)
    photo1 = create_studio_photo(studio, category)
    create_order(user, photo)
    create_order(user, photo1)

    assert_equal "$19.98", studio.revenue
  end

  test "activates all photos" do
    studio = create_studio
    category = create_category
    photo = create_studio_photo(studio, category)
    photo1 = create_studio_photo(studio, category)

    studio.activate_all_photos

    assert photo.active?
    assert photo1.active?
  end

  test "deactivates all photos" do
    category = create_category
    studio = create_studio
    photo = create_studio_photo(studio, category)
    photo1 = create_studio_photo(studio, category)

    studio.deactivate_all_photos

    refute photo.active?
    refute photo1.active?
  end
end
