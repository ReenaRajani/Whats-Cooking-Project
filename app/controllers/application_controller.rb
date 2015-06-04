class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  private
  def authenticate  # dont confuse with the user.authenticate
    @current_user = User.find session[:user_id] if session[:user_id]
  end 
end
