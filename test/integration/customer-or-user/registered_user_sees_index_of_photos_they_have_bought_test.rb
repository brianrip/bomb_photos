require 'test_helper'

class RegisteredUserSeesIndexOfPhotosTheyHaveBoughtTest < ActionDispatch::IntegrationTest
  test "I have an index of purchased photos" do
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    category = create_category
    studio = create_studio
    photo = create_studio_photo(studio, category)
    other_photo = studio.photos.create(name:        "Other Name",
                         description: "Example Description",
                         image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                         price:       999,
                         category_id: category.id
                         )
    UserPhoto.create(user_id: user.id, photo_id: photo.id)

    create_order(user, photo)

    visit dashboard_path
    click_on "My Purchased Photos"

    assert page.has_content?(photo.name)
    refute page.has_content?(other_photo.name)
  end

  test "user tries to buy photo they've bought previously" do
    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    category = create_category
    studio = create_studio
    photo = create_studio_photo(studio, category)
    UserPhoto.create(user_id: user.id, photo_id: photo.id)

    visit photos_path
    click_on "Add to Cart"

    visit cart_path
    click_on "Checkout"
    assert page.has_content?("You have already purchased one of the photos in your cart. Please go back and remove it, unless you would like to purchase it again.")
  end
end
