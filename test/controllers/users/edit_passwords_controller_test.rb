require "test_helper"

class Users::EditPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_edit_passwords_new_url
    assert_response :success
  end

  test "should get update" do
    get users_edit_passwords_update_url
    assert_response :success
  end
end
