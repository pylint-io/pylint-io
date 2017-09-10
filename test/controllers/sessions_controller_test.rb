require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "login logout routing" do
    assert_routing login_path, { controller: "sessions", action: "new" }
    assert_routing logout_path, { controller: "sessions", action: "destroy" }
  end

  test "login redirect" do
    get login_path
    assert_redirected_to "/auth/github"
  end
  
  test "logout redirect" do
    get logout_path
    assert_redirected_to root_path
  end

end