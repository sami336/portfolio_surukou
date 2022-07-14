class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
     redirect_to root_path
    else
     render :new
    end
  end
  
  def index
  end
  
  def show 
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def edit
  end
  
  private 
   
  def post_params
    params.require(:post).permit(:title, :body, :image_book)
  end
end
