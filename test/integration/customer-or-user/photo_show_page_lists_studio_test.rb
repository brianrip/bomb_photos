require 'test_helper'

class PhotoShowPageListsStudioTest < ActionDispatch::IntegrationTest
  test "visitor sees studio on photo show page" do
    category = create_category
    studio = create_studio
    photo = create_studio_photo(studio, category)

    visit photo_path(photo)

    assert page.has_content? studio.name
  end
end
