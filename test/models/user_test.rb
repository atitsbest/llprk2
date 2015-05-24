require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "store only hashed password" do
    User.create(name: 'tester', email: 'tester@test.test', password: '1234', password_confirmation: '1234')

    sut = User.first

    assert sut.authenticate('1234')
    assert_nil sut.password
    assert_not_nil sut.password_digest
  end
end
