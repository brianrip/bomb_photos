require 'test_helper'

class StudioIndexOnlyShowsActiveStudios < ActionDispatch::IntegrationTest
  test "only active studios show on index" do
    studio = Studio.create(name:        "Studio",
                           description: "Example description.",
                           status:      0
    )

    studio2 = Studio.create(name:        "Adrienne",
                           description: "Example description.",
                           status:      1
    )

    studio3 = Studio.create(name:        "Scott",
                           description: "Example description.",
                           status:      2
    )

    studio4 = Studio.create(name:        "Brian",
                           description: "Example description.",
                           status:      3
    )

    visit studios_path

    assert page.has_content?(studio.name)
    refute page.has_content?(studio2.name)
    refute page.has_content?(studio3.name)
    refute page.has_content?(studio4.name)
  end
end
