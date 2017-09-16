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

class UserTest < ActiveSupport::TestCase

  test "require valid service to save" do
    user = User.new
    user.service_uid = "123456890"
    user.token = "magic"
    assert_raises ActiveRecord::RecordInvalid do
      user.save!
    end
    user.service = "privategit"
    assert_raises ActiveRecord::RecordInvalid do
      user.save!
    end    
    user.service = "github"
    user.save!
  end

  test "require service_uid to save" do
    user = User.new
    user.service = "github"
    user.token = "magic"
    assert_raises ActiveRecord::RecordInvalid do
      user.save!
    end
    user.service_uid = "123456890"
    user.save!
  end

  test "require token to save" do
    user = User.new
    user.service = "github"
    user.service_uid = "123456890"
    assert_raises ActiveRecord::RecordInvalid do
      user.save!
    end
    user.token = "magic"
    user.save!
  end
  
  test "don't allow duplicate repositories" do
    user = User.new
    user.service = "github"
    user.service_uid = "123456890"
    user.token = "magic"
    user.repositories << repositories(:tomcatmanager)
    user.repositories << repositories(:tomcatmanager)
    user.save!
    assert user.repositories, [ repositories(:tomcatmanager) ]
  end
end
