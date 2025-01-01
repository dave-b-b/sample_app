require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  test 'user should be valid' do
    assert @user.valid?
  end

  test 'new action should work' do
    get users_new_url
    assert_response :success
  end

  test 'should return create page' do
    get users_new_url
    assert_response :success
    assert_select "input", count: 5

    assert_select "form", true
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user:
         {
           name: '',
           email: 'user@invalid',
           password: 'foo',
           password_confirmation: 'bar'
         }
      }
      assert_response :unprocessable_entity
      assert_template 'users/new'
      assert_select 'div#error_explanation'
      assert_select 'div.alert.alert-danger'
    end
  end

  test 'valid user signup' do
    assert_difference 'User.count', 1 do
      post users_path, params: {
       user:
        {
         name: 'David Brown',
         email: 'user2@example.com',
         password: 'asdfasdf',
         password_confirmation: 'asdfasdf'
        }
      }
      assert_response :redirect
      # The follow_redirect! allows for the page to remain so that
      # we can check other things like which template rendered
      # and what information is on the page
      follow_redirect!
      assert_template 'users/show'
      assert_select 'div.alert.alert-success'
      assert_select 'div.alert.alert-success', { count: 1, text:
                            'Welcome to the Sample App!'}
    end
  end

  # test 'user should return bad email error' do
  #   @user = @user.email = 'bad@email'
  #   post users_create_url, @user
  #   assert_response :error
  # end
end
