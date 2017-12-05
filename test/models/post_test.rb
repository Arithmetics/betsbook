require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:brock)
    @post = @user.posts.build(title: "yo yo", body: "whoa whoa")
  end

  test "post should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "title should be present" do
    @post.title = ""
    assert_not @post.valid?
  end

  test "content should not be over 280 char" do
    @post.body = "a" * 282
    assert_not @post.valid?
  end

  test "when user is deleted their posts should go as well" do
    @post.save
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end




end
