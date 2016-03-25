require 'test_helper'

class StudioAdminCanAddOrRemoveUserTest < ActionDispatch::IntegrationTest
  test "studio admin sees regular user appear as studio user acfter adding" do
    category = create_category
    studio = create_studio
    admin = create_and_login_studio_admin(studio)
    user = create_user

    visit 
    as a logged in studio admin,
    when I visit my dashboard,
    and I click on "Manage User Privileges"
    then I see list of all studio admins for my studio with a button to revoke admin status,
    and I see a list of all users with a button to grant admin status
    when I click on a users "Grant admin status" button,
    then I see a flah message that states "User.email has been allowed admin status"
    and I see such user in the admin user list,
    and I do not see the user in the registered site user path

  end
end
