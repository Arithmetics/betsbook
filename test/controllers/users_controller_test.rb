require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = "ds"
  end

  test "show get new" do
    get new_user_session_path
    assert_response :success
  end

end
