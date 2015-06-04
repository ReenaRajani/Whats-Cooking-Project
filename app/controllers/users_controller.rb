class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    
    if @user.save
      flash[:success] = "Welcome to the What's Cooking App!"
      redirect_to root_path
    else
      render :new
    end 
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update

  end



  private 
  def user_params
    params.require(:user).permit(:full_name,:email_id,:password ,:password_confirmation)
  end 
end
