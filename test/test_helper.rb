require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # fake an OmniAuth login
  def mock_login(user)
    # pass in a user fixture, and this thing will get them logged in
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[user.service.to_sym] = OmniAuth::AuthHash.new({
      :provider => user.service,
      :uid => user.service_uid,
      :credentials => {
        :token => user.token,
      },
    })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[user.service.to_sym]
    post "/auth/#{user.service}/callback"
  end
end
