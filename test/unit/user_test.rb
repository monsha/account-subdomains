require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  test "user must belongs to an account" do
    user = users(:benitez)
    user.account = nil
    assert !user.save
    assert_equal "can't be blank", user.errors[:account_id].join('; ')
  end
  
end
