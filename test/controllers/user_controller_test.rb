require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get signup header" do
    get signup_path
    assert_response :success
    assert_equal 'Sign up | Ruby on Rails Tutorial Sample App', full_title('Sign up')
    assert_select 'h1', count: 1
  end
end
