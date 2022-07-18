class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  private
  
  def admin_scan
    unless current_user.admin?
      redirect_to root_path
    end
  end
  
end
