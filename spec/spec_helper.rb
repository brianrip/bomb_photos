module SpecHelpers
  def create_user
    user = User.create(email: "user@example.com", password: "password")
  end

  def create_studio_photo(studio, category)
    studio.photos.create(name:        "Example Name",
                         description: "Example Description",
                         image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                         price:       999,
                         category_id: category.id
                         )
  end

  def create_category
    Category.create(name: "Example Category")
  end

  def create_studio
    Studio.create(name:        "Studio",
                  description: "Example description.",
                  status:      0
                  )
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecHelpers
end
