require "test_helper"

class Users::SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_session_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_session_destroy_url
    assert_response :success
  end
end
