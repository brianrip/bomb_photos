require 'test_helper'

class CustomerCanViewMultiplePastOrdersTest < ActionDispatch::IntegrationTest
  test "customer can see details of a past order" do

    category = create_category
    studio = create_studio
    user = create_user
    photo = create_studio_photo(studio, category)
    photo2 = studio.photos.create(name:       "Example Name",
                                  description: "Example Description",
                                  image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                  price:       999,
                                  category_id: category.id
                                  )
    order1 = create_order(user, photo)
    order2 = create_order(user, photo2)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path
    click_on "My Orders"

    assert page.has_content? order1.id
    assert page.has_content? order1.placed_at
    assert page.has_content? "$2.00"
    assert page.has_content? order2.id
    assert page.has_content? order2.placed_at
    assert page.has_content? "$2.00"
  end
end
