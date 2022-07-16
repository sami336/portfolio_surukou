class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts 
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  #いいね一覧
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
  
  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update_status_destroy
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image, :user_status, :image_book )
  end
end