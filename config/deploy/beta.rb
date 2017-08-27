#
# capistrano configuration for beta deployment

server "pylint.io", user: "deploy", roles: %w{web app db}

set :application, "beta.pylint.io"

# master branch goes to production, beta branch goes to beta
set :branch, "beta"
set :deploy_to, "/data/www/beta.pylint.io"
set :rails_env, "beta"
