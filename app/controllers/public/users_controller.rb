class Public::UsersController < ApplicationController
  def show
  end
   
  def edit
  end
  
  def update
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image, :user_status )
  end
end
