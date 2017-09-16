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

class RatingTest < ActiveSupport::TestCase

  test "require repository to save" do
    rating = Rating.new()
    rating.branch = "master"
    rating.module = "themodule"
    rating.rating = 8.89
    assert_raises ActiveRecord::RecordInvalid do
      rating.save!
    end
    rating.repository = repositories(:tomcatmanager)
    rating.save!
  end
  
  test "require branch to save" do
    rating = Rating.new()
    rating.repository = repositories(:tomcatmanager)
    rating.module = "themodule"
    rating.rating = 8.89
    assert_raises ActiveRecord::RecordInvalid do
      rating.save!
    end
    rating.branch = "master"
    rating.save!
  end

  test "require module to save" do
    rating = Rating.new()
    rating.repository = repositories(:tomcatmanager)
    rating.branch = "master"
    rating.rating = 8.89
    assert_raises ActiveRecord::RecordInvalid do
      rating.save!
    end
    rating.module = "themodule"
    rating.save!
  end
  
  test "require rating to save" do
    rating = Rating.new()
    rating.repository = repositories(:tomcatmanager)
    rating.branch = "master"
    rating.module = "themodule"
    assert_raises ActiveRecord::RecordInvalid do
      rating.save!
    end
    rating.rating = 8.89
    rating.save!
  end

end
