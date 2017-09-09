class User < ApplicationRecord
  has_and_belongs_to_many :repositories
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.service = auth.provider
      user.login = auth.extra.raw_info.login
      user.token = auth.credentials.token
    end
  end
end
