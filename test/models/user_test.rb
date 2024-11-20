require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "email_address cannot be nil" do
    user = User.new(email_address: nil)
    user.valid?
    assert user.errors.of_kind? :email_address, :blank
  end

  test "email_address must be unique" do
    one = users(:one)
    user = User.new(email_address: one.email_address)
    user.valid?
    assert user.errors.of_kind? :email_address, :taken
  end
end
