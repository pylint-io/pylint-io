require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest

  test "routing" do
    assert_routing( { path: "/ratings", method: :post }, controller: "ratings", action: "create")
  end

end
