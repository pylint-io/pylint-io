#
# capistrano configuration for production deployment

server "pylint.io", user: "deploy", roles: %w{web app db}

# master branch goes to production
set :branch, "master"
set :deploy_to, "/data/www/pylint.io"
set :rails_env, "production"
