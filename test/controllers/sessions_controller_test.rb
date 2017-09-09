require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "login logout routing" do
    assert_routing login_url, { controller: "sessions", action: "new" }
    assert_routing logout_url, { controller: "sessions", action: "destroy" }
  end

  test "login redirect" do
    get login_url
    assert_redirected_to "/auth/github"
  end
  
  test "logout redirect" do
    get logout_url
    assert_redirected_to root_url
  end

end