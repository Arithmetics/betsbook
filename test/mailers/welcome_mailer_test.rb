require 'test_helper'

class WelcomeMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "account creation" do
    user = users(:brock)
    mail = WelcomeMailer.welcome_send(user)
    assert_equal "Welcome to Betsbook", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["admin@betsbook.com"], mail.from
    assert_match user.username, mail.body.encoded
    assert_match "thanks for signing up!", mail.body.encoded
  end
end
