require 'test_helper'

class Admin::SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "create new session with valid credentials" do
    get :create, {email: 'tester@test.test', password:'1234'}

    assert_equal session[:user_id], users(:tester).id
    assert_redirected_to :admin_dashboard
  end

  test "redirect to login with invalid credentials" do
    get :create, {email: 'tester@test.test', password:'falsch'}

    assert_nil session[:user_id]
    assert_redirected_to :new_admin_session
  end

  test "current_user" do
    get :create, {email: 'tester@test.test', password:'1234'}

    assert_not_nil @controller.current_user
    assert_equal @controller.current_user.id, users(:tester).id
  end

  test "should get destroy" do
    get :create, {email: 'tester@test.test', password:'1234'}
    assert_not_nil session[:user_id]

    get :destroy

    assert_nil session[:user_id]
    assert_redirected_to :new_admin_session
  end

end
