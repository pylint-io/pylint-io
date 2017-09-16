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
 
class Repository < ApplicationRecord
  has_many :repository_users
  has_many :users, :through => :repository_users
  has_many :ratings, inverse_of: :repository
  
  validates :users, presence: true
  validates :service, presence: true, inclusion: { in: %w(github), message: "%{value} is not a valid service" }
  validates :owner, presence: true
  validates :name, presence: true
  
  # give a place to stash info from the service api
  attr_accessor :api_info
  
  def url
    if self.service == "github"
      "https://github.com/#{self.owner}/#{self.name}"
    end
  end

  def branches
    # find a list of branches for which we have ratings
    # self.ratings.select('distinct branch').map(&:branch)
    self.ratings.map { |r| r.branch }.uniq
  end
  
  def modules_in(branch)
    # find the modules in this branch for which we have ratings
    # self.ratings.where(branch: branch).select('distinct module').map(&:module)
    branch_ratings = self.ratings.select { |r| r.branch == branch }
    branch_ratings.map { |r| r.module }.uniq
  end
end
