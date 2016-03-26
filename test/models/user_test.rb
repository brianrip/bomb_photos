require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:password)
  should validate_presence_of(:email)
  should allow_value("email@addresse.foo").for(:email)
  should_not allow_value("foo").for(:email)
  should_not allow_value("foo@bar").for(:email)
  should_not allow_value("@bar.com").for(:email)
  should_not allow_value("bar.com").for(:email)
end
