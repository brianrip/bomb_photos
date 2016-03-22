require "test_helper"

class AdminCanLogInTest < ActionDispatch::IntegrationTest
  test "login with valid information" do
    studio = Studio.create(name:        "Studio",
                             description: "Example description.",
                             status:      "Approved"
    )

    admin = studio.users.create(username: "admin@example.com",
                                  password: "password",
                                  role:     1
    )

    visit login_path

    fill_in  "Username", with: "admin@example.com"
    fill_in  "Password", with: "password"
    click_on "Log in"

    assert_template "admin/dashboard#show"

    within("h1") do
      assert page.has_content?(studio.name)
    end
  end
end
