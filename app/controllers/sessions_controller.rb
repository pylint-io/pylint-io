class SessionsController < ApplicationController
  # create comes from a third party site
  protect_from_forgery :except => [:create]

  def new
    redirect_to '/auth/github'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:service => auth.provider,
                      :login => auth.extra.raw_info.login).first
    if user
      user.token = auth.credentials.token
      user.save
    else
      # user doesn't exist, go create them
      user = User.create_with_omniauth(auth)
    end
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
