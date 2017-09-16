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

class RepositoryUser < ApplicationRecord
  belongs_to :repository
  belongs_to :user
  validates :repository, presence: true
  validates :user, presence: true
end
