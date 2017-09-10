require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  test "url" do
    repo = repositories(:tomcatmanager)
    assert repo.url, "https://github.com/tomcatmanager/tomcatmanager"
  end
end
