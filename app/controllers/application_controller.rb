class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def authenticated?
    session[:user_id] != nil
  end

  def authenticate!
    if authenticated?
      @current_user = User.find(session[:user_id])
      @github = Octokit::Client.new(:access_token => @current_user.token)
    else
      flash[:error] = "You must be logged in."
      redirect_to root_url
    end
  end

end
