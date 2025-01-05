require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user)
    get login_path
  end
end


class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: {
      session: {
        email:    @user.email,
        password: 'password'
      }
    }
  end
end

class InvalidLogin < UsersLogin
  def setup
    post login_path, params: {
      session: {
        email:    'invalid@email.com',
        password: 'password'
      }
    }
  end
end

class LoginPageStructureTest < UsersLogin
  test 'login form appears correctly' do
    assert_select 'form', { count: 1 }
    assert_select 'input.form-control', { count: 2 }
  end
end

class InvalidPasswordTest < InvalidLogin
  test 'improper login returns flash only once' do
    assert_response :unprocessable_entity # 422
    assert_template 'sessions/new'
    assert_not flash.empty?
    get home_path
    assert flash.empty?
  end

  test 'login with valid email/invalid password' do
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_not flash.to_hash["danger"].include? "Welcome, "
    assert flash.to_hash["danger"].include? 'Invalid email/password combination'
  end
end

class UsersLoginTest < ValidLogin

  test 'test login page returns success' do
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end


  test 'check effects' do
    follow_redirect!
    assert flash.empty?
    assert is_logged_in?
    assert_select 'a[href=?]', logout_path, {count: 1}
    assert_select 'a[href=?]', login_path, {count: 0}
  end

  test 'login with valid information' do
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end



class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end

  test 'logged out shows correct header' do
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path, count: 1
  end

  test 'login with valid information followed by logout' do

    delete logout_path
    assert_not is_logged_in?
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', logout_url, {count: 0}
    assert_select 'a[href=?]', user_path(@user), {count: 0}
  end
end