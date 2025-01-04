require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'test login page returns success' do
    get login_url
    assert_response :success
  end

  test 'login form appears correctly' do
    get login_path
    assert_select 'form', {count: 1}
    assert_select 'input.form-control',  {count: 2}
  end

  test 'improper login returns flash only once' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session:
                               {
                                email: 'wrong@email.com',
                                password: 'asdfasdf'
                               }
    }
    assert_response :unprocessable_entity #422
    assert_template 'sessions/new'
    assert_not flash.empty?
    get home_path
    assert flash.empty?
  end
  #
  # test 'proper login displays flash' do
  #   get login_path
  #   assert_template 'sessions/new'
  #   post login_path, params: {session:
  #                               {
  #                                 email: 'example@railstutorial.org',
  #                                 password: 'asdfasdf'
  #                               }
  #   }
  #   assert flash.keys[0] == 'success'
  #
  # end
  test

end
