require "test_helper"

class Users::PasswordMailerTest < ActionMailer::TestCase
  test "reset_password" do
    mail = Users::PasswordMailer.reset_password
    assert_equal "Reset password", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
