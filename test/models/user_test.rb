require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:password)
  should validate_presence_of(:email)
  should allow_value("email@addresse.foo").for(:email)
  should_not allow_value("foo").for(:email)
  should_not allow_value("foo@bar").for(:email)
  should_not allow_value("@bar.com").for(:email)
  should_not allow_value("bar.com").for(:email)

  test "customer? returns true for customer" do
    customer_role = Role.create(name: "customer")
    user = User.create(email: "example@example.com", password: "password")
    user.roles << customer_role

    assert user.customer?
  end
end
