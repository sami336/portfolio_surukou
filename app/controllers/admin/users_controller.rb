class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts 
  end
  
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to admin_users_path
    else
       render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:user_status)
  end
  
end
