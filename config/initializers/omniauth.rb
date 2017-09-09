Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :github, Rails.application.secrets.github[:client_id],
           Rails.application.secrets.github[:client_secret], scope: "user,public_repo,read:org"
end
