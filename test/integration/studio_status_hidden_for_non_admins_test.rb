require 'test_helper'

class StudioStatusHiddenForNonAdminsTest < ActionDispatch::IntegrationTest
  test "guest cannot see studio status" do
    category = create_category
    studio   = create_studio

    visit "/#{studio.slug}"

    refute page.has_content?("Status")

    studio.update_attribute(:status, "pending")

    visit "/#{studio.slug}"

    refute page.has_content?("Status")
  end

  test "registered user cannot see studio status" do
    category = create_category
    studio   = create_studio
    user     = create_and_login_user

    visit "/#{studio.slug}"

    refute page.has_content?("Status")
  end

  test "non-affiliated admin cannot see studio status" do
    category = create_category

    studio_1 = create_studio
    studio_1.update_attribute(:name, "Studio 1")

    studio_2 = create_studio
    studio_2.update_attribute(:name, "Studio 2")

    user     = create_and_login_studio_admin(studio_1)

    visit "/#{studio_2.slug}"

    refute page.has_content?("Status")

    visit "/#{studio_1.slug}"

    assert page.has_content?("Status")
  end
end
