#
# Copyright (c) 2017 Muzo Labs
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# For a copy of the full license, see LICENSE file included in this
# distribution or http://www.gnu.org/license
# 

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
  
  test "require valid service to save" do
    repo = Repository.new()
    repo.owner = "pylint-io"
    repo.name = "pylint-io"
    repo.users << users(:one)
    assert_raises ActiveRecord::RecordInvalid do
      repo.save!
    end
    assert_raises ActiveRecord::RecordInvalid do
      repo.service = "privategit"
      repo.save!
    end
    repo.service = "github"
    repo.save!
  end
  
  test "require owner to save" do
    repo = Repository.new()
    repo.service = "github"
    repo.name = "pylint-io"
    repo.users << users(:one)
    assert_raises ActiveRecord::RecordInvalid do
      repo.save!
    end
    repo.owner = "pylint-io"
    repo.save!
  end

  test "require name to save" do
    repo = Repository.new()
    repo.service = "github"
    repo.owner = "pylint-io"
    repo.users << users(:one)
    assert_raises ActiveRecord::RecordInvalid do
      repo.save!
    end
    repo.name = "pylint-io"
    repo.save!
  end

  test "require at least one user to save" do
    repo = Repository.new()
    repo.service = "github"
    repo.owner = "pylint-io"
    repo.name = "pylint-io"
    assert_raises ActiveRecord::RecordInvalid do
      repo.save!
    end
    repo.users << users(:one)
    repo.save!
  end

  test "don't allow duplicate users" do
    repo = Repository.new()
    repo.service = "github"
    repo.owner = "pylint-io"
    repo.name = "pylint-io"
    repo.users << users(:one)
    repo.users << users(:one)
    repo.save!
    assert repo.users, [ users(:one) ]
  end
end
