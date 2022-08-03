require "test_helper"

class Users::PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get users_passwords_edit_url
    assert_response :success
  end

  test "should get update" do
    get users_passwords_update_url
    assert_response :success
  end
end
