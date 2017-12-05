require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include  Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:brock)
  end

  test "index all users show up, except logged in user" do
    sign_in @user
    get users_path
    assert_template 'users/index'
    #check to see all the users are listed on the index page
    #leave out the current user 
    User.all.each do |user|
      if user.username = @user.username
        assert_select 'a[href=?]', user_path(user), text: user.username, count: 0
      else
        assert_select 'a[href=?]', user_path(user), text: user.username
      end
    end
  end

end
