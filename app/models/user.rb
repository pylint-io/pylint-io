class User < ApplicationRecord
  has_and_belongs_to_many :repositories
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.service = auth['provider']
      user.service_uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end
end
