require 'test_helper'

class StudioAdminCanAddOrRemoveUserTest < ActionDispatch::IntegrationTest
  test "studio admin changes status of standard user to appear as studio admin" do
    category = create_category
    studio = create_studio
    admin = create_studio_admin(studio)
    user = create_user
    user.update_attribute(:email, "email@example.com")
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_path(studio)
    click_on "Manage studio administrative privileges"
    assert page.has_button? "Revoke admin status for user #{admin.id}"

    fill_in "Email", with: "email@example.com"
    click_on "Grant admin status"
    assert page.has_content? "#{user.email} has been granted admin status!"

    assert page.has_button? "Revoke admin status for user #{admin.id}"
  end

  test "studio admin removes a fellow studio admin but not self" do
    category = create_category
    studio = create_studio
    admin = create_studio_admin(studio)
    admin2 = create_studio_admin(studio)

    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_path(studio)
    click_on "Manage studio administrative privileges"

    assert page.has_button? "Revoke admin status for user #{admin2.id}"

    click_on "Revoke admin status for user #{admin.id}"
    assert page.has_content?"You cannot remove yourself at this time, please contact Bomb Photos to perform this action."

    click_on "Revoke admin status for user #{admin2.id}"
    assert page.has_content? "You have removed admin status for #{admin2.email}"
    refute page.has_button? "Revoke admin status for user #{admin2.id}"
  end

  test "studio admin cannot visit another studio admins user index" do
    category = create_category
    studio = create_studio
    studio2 = Studio.create(name:        "Studio2",
                            description: "Example description.2",
                            status:      0,
                            promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                            )
    admin = create_studio_admin(studio)
    admin2 = create_studio_admin(studio2)

    user = create_user
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit admin_path(studio2)
    assert page.has_content? "The page you were looking for doesn't exist"
  end
end
