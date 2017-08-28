require 'test_helper'

class BadgeControllerTest < ActionDispatch::IntegrationTest

  test "github routing" do
    assert_routing "github/org/repo/branch/module.svg",
      { controller: "badge", action: "github", organization: "org", repository: "repo",
        branch: "branch", module: "module", format: "svg" }
    assert_routing "github/org/repo.svg",
      { controller: "badge", action: "github", organization: "org", repository: "repo",
        format: "svg" }
    assert_routing "github/org/repo/module.svg",
      { controller: "badge", action: "github", organization: "org", repository: "repo",
        module: "module", format: "svg" }
  end
  test "github routing org only" do
    r = ratings(:one)
    assert_raises(ActionController::RoutingError) do
      get "/github/#{r.organization}.svg"
    end
  end


  test "github org repo" do
    r = ratings(:one)
    get "/github/#{r.organization}/#{r.repository}.svg"
    assert_response :success
    assert @response.body.include? r.rating.to_s
  end
  test "github org repo module" do
    r = ratings(:one)
    get "/github/#{r.organization}/#{r.repository}/#{r.module}.svg"
    assert_response :success
    assert @response.body.include? r.rating.to_s
  end
  test "github org repo branch module" do
    r = ratings(:two)
    get "/github/#{r.organization}/#{r.repository}/#{r.branch}/#{r.module}.svg"
    assert_response :success
    assert @response.body.include? r.rating.to_s
  end
  
  
  test "github org unknown repo" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/github/#{r.organization}/#{random}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
  test "github org repo default branch unknown module" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/github/#{r.organization}/#{r.repository}/#{random}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
  test "github org repo unknown branch" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/github/#{r.organization}/#{r.repository}/#{random}/#{r.module}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
  test "github org repo branch unknown module" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/github/#{r.organization}/#{r.repository}/#{r.branch}/#{random}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
end