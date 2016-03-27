require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "minitest/pride"
require 'mocha/mini_test'

class ActiveSupport::TestCase
  DatabaseCleaner.strategy = :transaction

  def create_category
    Category.create(name: "Example Category")
  end

  def create_studio
    Studio.create(name:        "Studio",
                  description: "Example description.",
                  status:      0,
                  promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                  )
  end

  def create_and_login_studio_admin(studio)
    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                role:     1
                                )
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
  end

  def create_user
    User.create(email: "user@example.com", password: "password")
  end

  def create_and_login_user
    User.create(email: "user@example.com", password: "password")
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  def create_order(user, photo)
    order_photo = OrderPhoto.create(photo_id: photo.id)
    order = user.orders.create(total_price: 200)
    order.order_photos << order_photo
    order
  end

  def create_studio_photo(studio, category)
    studio.photos.create(name:        "Example Name",
                         description: "Example Description",
                         image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                         price:       999,
                         category_id: category.id
                         )
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    reset_session!
    DatabaseCleaner.start
    super
  end

  def teardown
    reset_session!
    DatabaseCleaner.clean
    super
  end

  def customer_role
    Role.create(name: "customer")
  end

  def studio_admin_role
    Role.create(name: "studio admin")
  end

  def platform_admin_role
    Role.create(name: "platform admin")
  end

  def create_category
    Category.create(name: "Example Category")
  end

  def create_studio
    Studio.create(name:        "Studio",
                  description: "Example description.",
                  status:      0,
                  promo_image: "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png"
                  )
  end

  def create_and_login_studio_admin(studio)
    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                )
    admin.roles << studio_admin_role
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    admin
  end

  def create_and_login_studio_platform_admin(studio)
    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                )
    admin.roles << customer_role
    admin.roles << studio_admin_role
    admin.roles << platform_admin_role
    admin
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
  end

  def create_and_login_platform_admin
    admin = User.create(email:  "admin@eample.com",
                                password: "password",
                                )
    admin.roles << platform_admin_role
    admin
    ApplicationController.any_instance.stubs(:current_user).returns(admin)
  end

  def create_studio_admin(studio)
    admin = studio.users.create(email:  "admin@eample.com",
                                password: "password",
                                )
    admin.roles << studio_admin_role
    admin
  end

  def create_user
    user = User.create(email: "user@example.com", password: "password")
    user.roles << customer_role
    user
  end

  def create_and_login_user
    user = User.create(email: "user@example.com", password: "password")
    user.roles << customer_role
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  def create_order(user, photo)
    order_photo = OrderPhoto.create(photo_id: photo.id)
    order = user.orders.create(total_price: 200)
    order.order_photos << order_photo
    order
  end

  def create_studio_photo(studio, category)
    studio.photos.create(name:        "Example Name",
                         description: "Example Description",
                         image:       "https://placeholdit.imgix.net/~text?txtsize=60&bg=000000&txt=640%C3%97480&w=640&h=480&fm=png",
                         price:       999,
                         category_id: category.id
                         )
  end
end
