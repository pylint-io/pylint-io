class Repository < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :ratings #, -> { order "branch, module, created_at DESC" }
  
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
