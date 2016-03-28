require 'test_helper'

class RegisteredUserCannotAccessInactiveStudioTest < ActionDispatch::IntegrationTest
  test "registered user tries to access inactive studio" do
    user = create_user
    active = create_studio
    inactive_studio = Studio.create(name:        "inactive",
                                    description: "Example description.",
                                    status:      1,
                                    promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                    )
    pending_studio = Studio.create(name:        "pending",
                                    description: "Example description.",
                                    status:      2,
                                    promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                    )
    denied_studio = Studio.create(name:        "denied",
                                    description: "Example description.",
                                    status:      3,
                                    promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                                    )
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit studios_path
    assert page.has_content?(active.name)
    refute page.has_content?(inactive_studio.name)
    refute page.has_content?(pending_studio.name)
    refute page.has_content?(denied_studio.name)
    visit studio_path(inactive_studio)
    assert page.has_content?("The page you were looking for doesn't exist")
    visit studio_path(pending_studio)
    assert page.has_content?("The page you were looking for doesn't exist")
    visit studio_path(denied_studio)
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
