require 'test_helper'

class StudioAdminEditsStudio < ActionDispatch::IntegrationTest
  test "studio admin edits their own studio" do
    studio = create_studio
    create_and_login_studio_admin(studio)

    visit admin_path(studio)
    click_on "Edit Studio"
    fill_in "Name", with: "Different Name"

    click_on "Update Studio"

    assert page.has_content?("Your studio has been updated!")
    assert page.has_content?("Different Name")
  end

  test "studio admin must enter all fields" do
    studio = create_studio
    create_and_login_studio_admin(studio)

    visit admin_path(studio)

    click_on "Edit Studio"

    fill_in "Name", with: ""

    click_on "Update Studio"

    assert page.has_content?("You must provide all information.")
  end

  test "studio admin cannot edit another studio" do
    other_studio = Studio.create(name:        "Other Studio",
                  description: "Example description.",
                  status:      0,
                  promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                  )
    other_studio.users.create(email: "other_user@example.com", password: "password")
    studio = create_studio
    create_and_login_studio_admin(studio)

    visit edit_studio_path(other_studio)
    assert page.has_content?("The page you were looking for doesn't exist (404)")
    assert page.has_content?("You can only edit a studio that belongs to you")
  end
end
