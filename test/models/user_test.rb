require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:brock)
  end

  test "user valid" do
    assert @user.valid?
  end


end
