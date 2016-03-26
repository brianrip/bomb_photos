require 'test_helper'

class PlatformAdminCanViewVariousStudioDashboardsTest < ActionDispatch::IntegrationTest
  test "platform admin can access studio admin dashboards" do
    studio = create_studio
    other_studio = Studio.create(name: "Other Studio",
                                 description: "Example description.",
                                 status:      0,
                                 promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                 )
    create_and_login_platform_admin
    visit platform_admin_dashboard_path
    click_on studio.name
    assert page.has_content?("#{studio.name}: Admin Dashboard")

    visit platform_admin_dashboard_path
    click_on other_studio.name
    assert page.has_content?("#{other_studio.name}: Admin Dashboard")
  end
end
