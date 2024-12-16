require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get default_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", default_path, count: 1
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  test 'title helper' do
    get contact_path
    assert_select 'title', full_title('Contact')
    assert_equal 'Contact | Ruby on Rails Tutorial Sample App', full_title('Contact')
    assert_equal 'Ruby on Rails Tutorial Sample App', full_title('')
  end
end
