require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user)
  end

  test 'test login page returns success' do
    get login_url
    assert_response :success
  end

  test 'login form appears correctly' do
    get login_path
    assert_select 'form', { count: 1 }
    assert_select 'input.form-control', { count: 2 }
  end

  test 'improper login returns flash only once' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session:
                                 {
                                   email:    'wrong@email.com',
                                   password: 'asdfasdf'
                                 }
    }
    assert_response :unprocessable_entity # 422
    assert_template 'sessions/new'
    assert_not flash.empty?
    get home_path
    assert flash.empty?
  end

  test 'login with valid information' do
    post login_path, params: {
      session: {
        email:    @user.email,
        password: 'password'
      }
    }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test 'logged out shows correct header' do
    get home_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path, count: 1
  end

end
