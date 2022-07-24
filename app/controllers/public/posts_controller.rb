class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to root_path
    else
     render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
      post.save_tag(tag_list)
      redirect_to post_path(post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    tags = post.tags.pluck(:id)
    post.destroy
    tags.each do |tag_id|
      count = PostTag.where(tag_id: tag_id).count
      if count <= 0
        Tag.find(tag_id).destroy
      end
    end
    redirect_to user_path(post.user_id)
  end

  def search_tag
    @tag_list = Tag.all
    @tag =Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).per(10)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image_book)
  end
end
