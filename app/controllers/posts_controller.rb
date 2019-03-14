class PostsController < ApplicationController
  def index
    @posts = Post.order('created_at DESC').paginate(page: params[:page], per_page: 6)
  end

  def show
    @post = Post.friendly.find(params[:id])
    @posts = @post.author.posts.where.not(slug: params[:id])
  end
end