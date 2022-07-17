class Public::HomesController < ApplicationController
  def top
    @posts = Post.page(params[:page])
    @tag_list = Tag.all
  end
end
