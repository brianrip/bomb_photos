require 'test_helper'

class PlatformAdminChangesStatusOfStudioTest < ActionDispatch::IntegrationTest
  test "logged in platform admin makes inactive studio active" do
    studio = Studio.create(name:        "Studio",
                  description: "Example description.",
                  status:      0,
                  promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                  )

    category = create_category
    photo = create_studio_photo(studio, category)
    create_and_login_platform_admin
    visit platform_admin_dashboard_path
    click_on "Deactivate"
    assert page.has_content?("#{studio.name} has been deactivated")
    assert page.has_content?("inactive")

    visit photo_path(photo)
    refute page.has_content?("Add to Cart")

    visit platform_admin_dashboard_path

    click_on "Activate"
    assert page.has_content?("#{studio.name} has been activated")
    assert page.has_content?("active")

    visit photo_path(photo)
    assert page.has_content?("Add to Cart")
  end
end
