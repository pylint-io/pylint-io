require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "routing" do
    assert_routing "/", {controller: "home", action: "index"}
  end
  
  test "should get index" do
    get root_url
    assert_response :success
  end

end
