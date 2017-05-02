require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invaild signup information" do
    get signup_path

    assert_select 'form[action="/signup"]'

    assert_no_difference 'User.count' do
      post users_path, params: {user: {
          name: "",
          email: "user.invaild",
          password: "foo",
          password_confirmation: "bar"
      }}
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'
  end

  test "valid signup information" do
    get signup_path

    assert_difference 'User.count', 1 do
      post users_path, params: {user: {
          name: "ExampleUser",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
      }}
    end

    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
