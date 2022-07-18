class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts 
  end
  
  def index
    @users = User.all
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_status: true)
       reset_session
       redirect_to admin_posts_path
    else
       render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:user_status )
  end
  
end
