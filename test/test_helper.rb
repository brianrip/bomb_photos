ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "minitest/pride"
require 'mocha/mini_test'
require 'database_cleaner'

DatabaseCleaner[:active_record].strategy = :truncation, {except: %w[public.schema_migrations]}

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  # DatabaseCleaner.strategy = :transaction
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

  # def create_and_return_admin
  #   admin = User.create(username: "July", password: "password", role: 1)
  #   ApplicationController.any_instance.stubs(:current_user).returns(admin)
  # end
  #
  # def create_and_login_user
  #   user = User.create(username: "Brock", password: "password")
  #
  #   visit '/'
  #
  #   click_on "login"
  #
  #   fill_in "Username", with: "Brock"
  #   fill_in "Password", with: "password"
  #
  #   within ".login" do
  #     click_on "Login"
  #   end
  # end
  #
  # def create_multiple_orders(num)
  #   num.times do
  #     user = create(:user)
  #     gif = create(:gif)
  #     OrderGif.create(
  #       gif_id: gif.id, quantity: 1, subtotal: 100
  #     )
  #     order = user.orders.create!(total_price: 100, status: 0)
  #
  #     gif = create(:gif)
  #     order.order_gifs.create(
  #       gif_id: gif.id, quantity: 2, subtotal: 100
  #     )
  #   end
  # end
  #
  # def create_a_gif
  #   visit admin_dashboard_path
  #   click_on "Add New Gif"
  #
  #   fill_in "Title", with: "all of teh lulz"
  #   fill_in "Description", with: "this is all the lulz you could imagine!!"
  #   fill_in "Price", with: "100"
  #   fill_in "Tags", with: "lulzy, defeated, dusty"
  #   attach_file "Image", "test/asset_tests/gifs/carmer-got-carmed.gif"
  #
  #   click_on "add new gif!"
  # end
end
