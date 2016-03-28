require 'test_helper'

class PlatformAdminRespondsToStudioApplicationTest < ActionDispatch::IntegrationTest
  test "platform admin denies studio application" do

    other_studio = Studio.create(name: "Other Studio",
                                 description: "Example description.",
                                 status:      2,
                                 promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                 )
    create_and_login_platform_admin
    visit platform_admin_dashboard_path
    click_on "Approve/Deny"
    assert page.has_content?("Photos by #{other_studio.name}")
    click_on "Deny"
    assert page.has_content?("#{other_studio.name} has been denied")
    visit studio_path(other_studio)
    assert page.has_content?("Status: denied")
   end

  test "platform admin approves studio application" do
    other_studio = Studio.create(name: "Other Studio",
                                 description: "Example description.",
                                 status:      2,
                                 promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                 )
    create_and_login_platform_admin
    visit platform_admin_dashboard_path
    click_on "Approve/Deny"
    assert page.has_content?("Photos by #{other_studio.name}")
    click_on "Approve"
    assert page.has_content?("#{other_studio.name} has been approved and activated")
    visit studio_path(other_studio)
    assert page.has_content?("Status: active")
  end

  test "studio admins don't see approve or deny buttons on studio show page" do
    studio = Studio.create(name: "Other Studio",
                                 description: "Example description.",
                                 status:      2,
                                 promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                 )
    visit studio_path(studio)
    refute page.has_content?("Deny")
    refute page.has_content?("Approve")
  end
end
