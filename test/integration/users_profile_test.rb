require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers


  def setup
    @user = users(:brock)
  end


  test "redirected to login on root call, not logged in" do
    get root_path
    assert_redirected_to new_user_session_path
  end

  test "login user, check page content" do
    sign_in @user
    get root_path
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", user_path(@user)
    assert_select 'h1', text: "Welcome to your page #{@user.username}"
    @user.posts.take(10).each do |post|
      assert_match post.body, response.body
    end
  end


end
