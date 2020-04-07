class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize

  helper_method :current_user
  
  protected
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorize
    redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  def drop_session
    session[:user_id] = nil
  end
end
