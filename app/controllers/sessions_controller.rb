class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by :email_id => params[:session][:email_id].downcase
    if user.present? && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:notice] = "Invalid login , please try again."
      redirect_to login_path
    end

  end


  def destroy
    session[:user_id] = nil
    @current_user = nil

    redirect_to root_path
  end 
end
