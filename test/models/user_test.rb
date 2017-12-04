require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(username: "Reg User", email: "reguser1@example.com")
  end

  test "user should be valid" do
    assert @user.valid?
  end

end
