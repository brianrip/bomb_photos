require 'test_helper'

class UserSeesRespectiveDashboardLinksTest < ActionDispatch::IntegrationTest
  test "platform studio admin customer sees three account links in nav " do
    studio = create_studio
    create_and_login_studio_platform_admin(studio)
    visit root_path

    assert page.has_content? "Customer account"
    assert page.has_content? "#{studio.name} admin account"
    assert page.has_content? "Platform admin account"
  end

  test "studio admin customer sees two account links in nav " do
    studio = create_studio
    create_and_login_studio_platform_admin(studio)

    visit root_path

    assert page.has_content? "Customer account"
    assert page.has_content? "#{studio.name} admin account"
  end

  test "customer sees one account link in nav " do
    studio = create_studio
    create_and_login_studio_platform_admin(studio)

    visit root_path

    assert page.has_content? "Customer account"
  end
end
