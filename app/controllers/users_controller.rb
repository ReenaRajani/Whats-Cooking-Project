class UsersController < ApplicationController
 
  before_action :check_if_admin, :only => [:index]

  def index
    @users = User.all
  end 

   def new
    @user = User.new
  end


  def create
    @user = User.new user_params
    
    if @user.save

      session[:user_id] = @                                                       user.id
      flash[:success] = "Welcome to the What's Cooking App!"
      redirect_to @user
    else
      render :new
    end 
  end


  def edit
    @user = @current_user
    render :new
  end

  def update
    user = @current_user
    user.update user_params
    redirect_to root_path

  end




  private 
  def user_params
    params.require(:user).permit(:full_name,:email_id,:password ,:password_confirmation)
  end 

   def check_if_admin
    redirect_to root_path unless @current_user.present? && @current_user.admin?
  end
end
