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

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:tomcatmanager)
    mock_login(users(:one))
  end


  ##  TODO mock up github
  # test "should get index" do
  #   get repositories_path
  #   assert_response :success
  # end

  ##  TODO mock up github
  # test "should get new" do
  #   get new_repository_url
  #   assert_response :success
  # end

  test "should create repository" do
    assert_difference('Repository.count') do
      post repositories_url, params: { repository: { service: "github", owner: "pylint-io", name: "mynewrepo" } }
    end
    assert_redirected_to repository_url(Repository.last)
  end


  ## TODO mock up github
  # test "should show repository" do
  #   get repository_url(@repository)
  #   assert_response :success
  # end

  test "should destroy repository" do
    assert_difference('Repository.count', -1) do
      @repository = repositories(:tomcatmanager)
      delete repository_url(@repository)
    end
    assert_redirected_to repositories_url
  end
end
