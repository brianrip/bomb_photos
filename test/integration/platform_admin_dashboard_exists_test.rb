require 'test_helper'

class PlatformAdminDashboardExistsTest < ActionDispatch::IntegrationTest
  test "user visits platform admin dashboard" do
    category = create_category
    studio = create_studio

    studio2 = Studio.create(name:        "Studio2",
                           description: "Example description2.",
                           status:      1,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    studio3 = Studio.create(name:        "Studio3",
                           description: "Example description3.",
                           status:      2,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    studio4 = Studio.create(name:        "Studio4",
                           description: "Example description4.",
                           status:      3,
                           promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
    )

    studio.photos.create(name:        "Example Name",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    studio2.photos.create(name:        "Example Name 2",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    studio2.photos.create(name:        "Example Name 3",
                                 description: "Example Description",
                                 image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                                 price:       999,
                                 category_id: category.id
    )

    visit platform_admin_dashboard_path
    assert page.has_content?(studio.name)
    assert page.has_content?(studio2.name)
    assert page.has_content?(studio3.name)
    assert page.has_content?(studio4.name)
    assert page.has_content?(studio.id)
    assert page.has_content?(studio2.id)
    assert page.has_content?(studio3.id)
    assert page.has_content?(studio4.id)
    assert page.has_content?(studio.created_at)
    assert page.has_content?(studio.created_at)
    assert page.has_content?(studio2.created_at)
    assert page.has_content?(studio2.created_at)
    assert page.has_content?(studio.updated_at)
    assert page.has_content?(studio2.updated_at)
    assert page.has_content?(studio3.updated_at)
    assert page.has_content?(studio4.updated_at)
    assert page.has_content?(studio.status)
    assert page.has_content?(studio2.status)
    assert page.has_content?(studio3.status)
    assert page.has_content?(studio4.status)
    assert page.has_button?("Activate")
    assert page.has_button?("Deactivate")
    assert page.has_button?("Approve")
    assert page.has_button?("Deny")
    assert page.has_content?("Number of Photos")
    assert page.has_content?("1")
    assert page.has_content?("2")
  end
end
