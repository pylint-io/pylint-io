require 'test_helper'

class BadgeControllerTest < ActionDispatch::IntegrationTest

  test "github routing svg" do
    assert_routing "/badge/github/org/repo/branch/module.svg",
      { to: "badge#github", controller: "badge", action: "github", owner: "org",
        repository: "repo", branch: "branch", module: "module", format: "svg" }
    assert_routing "/badge/github/org/repo.svg",
      { to: "badge#github", controller: "badge", action: "github", owner: "org",
        repository: "repo", format: "svg" }
    assert_routing "/badge/github/org/repo/module.svg",
      { to: "badge#github", controller: "badge", action: "github", owner: "org",
        repository: "repo", module: "module", format: "svg" }
  end
  test "github routing json" do
    assert_routing "/badge/github/org/repo/branch/module",
      { to: "badge#github", controller: "badge", action: "github", owner: "org",
        repository: "repo", branch: "branch", module: "module", format: :json }
    assert_routing "/badge/github/org/repo",
      { to: "badge#github", controller: "badge", action: "github", owner: "org",
        repository: "repo", format: :json }
    assert_routing "/badge/github/org/repo/module",
      { to: "badge#github", controller: "badge", action: "github", owner: "org",
        repository: "repo", module: "module", format: :json }
  end
  test "github routing org only svg" do
    r = ratings(:one)
    assert_raises(ActionController::RoutingError) do
      get "/badge/github/#{r.repository.owner}.svg"
    end
  end


  test "github org repo svg" do
    r = ratings(:one)
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}.svg"
    assert_response :success
    assert @response.body.include? r.rating.to_s
  end
  test "github org repo json" do
    r = ratings(:one)
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}", as: :json
    assert_response :success
    assert_equal JSON.parse(@response.body)["rating"], r.rating.to_s
  end
  
  test "github org repo module" do
    r = ratings(:one)
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}/#{r.module}.svg"
    assert_response :success
    assert @response.body.include? r.rating.to_s
  end
  test "github org repo branch module" do
    r = ratings(:two)
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}/#{r.branch}/#{r.module}.svg"
    assert_response :success
    assert @response.body.include? r.rating.to_s
  end
  
  
  test "github org unknown repo" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/badge/github/#{r.repository.owner}/#{random}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
  test "github org repo default branch unknown module" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}/#{random}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
  test "github org repo unknown branch" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}/#{random}/#{r.module}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
  test "github org repo branch unknown module" do
    r = ratings(:one)
    random = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    get "/badge/github/#{r.repository.owner}/#{r.repository.name}/#{r.branch}/#{random}.svg"
    assert_response :success
    assert @response.body.include? "unknown"
  end
end
