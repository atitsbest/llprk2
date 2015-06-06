require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
    test "should need login" do
        get :index
        assert_redirected_to :new_admin_session
    end
end

