require "test_helper"

class Users::ResetPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_reset_passwords_new_url
    assert_response :success
  end

  test "should get create" do
    get users_reset_passwords_create_url
    assert_response :success
  end
end
