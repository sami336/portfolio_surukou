class Public::HomesController < ApplicationController
  def top
    @posts = Post.page(params[:page]).order(created_at: :desc)
    @tag_list = Tag.all
  end
end
