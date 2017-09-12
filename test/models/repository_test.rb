require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  test "url" do
    repo = repositories(:tomcatmanager)
    assert repo.url, "https://github.com/tomcatmanager/tomcatmanager"
  end
  
  test "branches" do
    repo = repositories(:tomcatmanager)
    assert repo.branches, ["develop", "master"]
  end
  
  test "modules" do
    repo = repositories(:tomcatmanager)
    assert repo.modules_in("master"), ["tomcatmanager"]
  end
end
