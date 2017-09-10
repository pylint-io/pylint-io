class Repository < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :ratings
  
  def url
    if self.service == "github"
      "https://github.com/#{self.organization}/#{self.name}"
    end
  end
end
